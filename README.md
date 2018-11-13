# Description
This is the docker image for [ADITO](https://www.adito.de) Mobile 
You need an ADITO Server with enabled SOAP webservices

# Usage

    docker run -d -p 8080:8080 -p 8443:8443 --name aditomobile adito/aditomobile

## Environment Variables

All common environment variables with their default values are listed below.

### `HTTPPORT=8080`

http port inside the container

### `HTTPSPORT=8443`

https port inside the container

### `APIURL=`

URL to API of ADITO Server based on this scheme: http://ADITO_SERVER_HOST:ADITO_SERVER_PORT/run-process?wsdl

for example: http://adito:7934/run-process?wsdl

## using a valid server certificate

You need to mount an pkc12-keystore with an alias tomcat to the container into "/usr/local/tomcat/conf/localhost-rsa.jks" (see docker-compose for reference)

Use the default password "changeit" for the key and keystore


## docker-compose

```
services:
  aditomobile:
    environment:
      APIURL: http://adito:7934/run-process?wsdl
      HTTPPORT: '8082'
      HTTPSPORT: '8441'
    image: adito/aditomobile
    ports:
    - 8443:8443/tcp
    - 8080:8080/tcp
    restart: always
    volumes:
    - /volume/aditomobile/localhost-rsa.jks:/usr/local/tomcat/conf/localhost-rsa.jks:rw
version: '2.1'
```
