FROM ubuntu:16.04
LABEL author=sjohnstone

# Environment Vars
ENV LDAP_ROOTPASS default
ENV LDAP_ORGANISATION test
ENV LDAP_DOMAIN test.com

# Install section
RUN apt-get -y update
RUN apt-get install supervisor -y
RUN LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y slapd ldap-utils
RUN apt-get install phpldapadmin -y
RUN apt-get -y clean

# Apache config
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN apache2ctl configtest

# Configure slapd (NB at some point we should move the bash script into Docker)
RUN mkdir -p /root/slapd/
ADD docker-entrypoint.sh /root/slapd/
ADD config.php /etc/phpldapadmin/
RUN chmod +x /root/slapd/docker-entrypoint.sh

# Configure supervisor (enables you to start two processes)
RUN echo "[supervisord]" > /etc/supervisord.conf && \
    echo "nodaemon=true" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    echo "[program:httpd]" >> /etc/supervisord.conf && \
    echo "command=/usr/sbin/apache2ctl -D FOREGROUND" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf && \
    echo "[program:docker-entrypoint]" >> /etc/supervisord.conf && \
    echo "command=/root/slapd/docker-entrypoint.sh" >> /etc/supervisord.conf && \
    echo "" >> /etc/supervisord.conf

# Expose section
EXPOSE 80
EXPOSE 389

# Load container
CMD ["/usr/bin/supervisord"]