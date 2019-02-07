#OpenLDAP

## Getting started

To build this docker image run the following

```
docker build -t platform-components/ldap-server:latest .
```



## Other 

### Delete images and containers

```
docker rm $(docker ps -a -q) && docker rmi $(docker images -q)
```