# OpenLDAP

## Getting started

To build this docker image run the following

```
docker build -t platform-components/ldap-server:latest .
```

Once build use the following to run this

```
docker run -p 80:80 -d platform-components/ldap-server:latest 
```


## Other 

### Delete images and containers

```
docker rm $(docker ps -a -q) && docker rmi $(docker images -q)
```

### Debug issues

To see what's going on inside a running container you can use 

```
docker exec -i -t [containerid] /bin/bash
```