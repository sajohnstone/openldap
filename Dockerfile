FROM ubuntu:16.04
LABEL author=sjohnstone

# Install section
RUN apt-get -y update
RUN apt-get install supervisor -y
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y slapd
RUN apt-get install phpldapadmin -y
RUN apt-get -y clean

#RUN apt-get -y install apache2 && apt-get -y clean

# Install slapd
#RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y slapd
#RUN apt-get install phpldapadmin -y

# Apache config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apache2ctl configtest

# Configure supervisor
RUN echo "[supervisord]" > /etc/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    echo "[program:httpd]" >> /etc/supervisord.conf && \
    echo "command=/usr/sbin/apache2ctl -D FOREGROUND" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    #echo "[program:docker-entrypoint]" >> /etc/supervisord.conf && \
    #echo "command=/root/slapd/docker-entrypoint.sh" >> /etc/supervisord.conf && \
    #echo "" >> /etc/supervisord.conf && \
    echo "[program:slapd]" >> /etc/supervisord.conf && \
    echo "command=/etc/init.d/slapd start" >> /etc/supervisord.conf


# Expose 
EXPOSE 80
#EXPOSE 389

# Load container
#CMD ["/opt/bin/start-apache.sh"]
#ENTRYPOINT ["apache2", "-D", "FOREGROUND"]
#CMD apachectl -D FOREGROUND

CMD ["/usr/bin/supervisord"]