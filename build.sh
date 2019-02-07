echo "remove existing image.."
docker image rm platform-components/ldap-server:latest -f
echo "build it"
docker build -t platform-components/ldap-server:latest .
echo "run it"
docker run -it -p 8080:80 platform-components/ldap-server:latest