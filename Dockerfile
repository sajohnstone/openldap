FROM ubuntu:16.04
MAINTAINER sjohnstone

# Install apache
RUN apt-get -y install apache2

# Expose 
EXPOSE 80
#EXPOSE 389