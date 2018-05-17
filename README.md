# Description
This is the docker image for [ADITO](https://www.adito.de) Mobile 
You need to run this container a running ADITO Server 

# Usage

    docker run -i -p 80:8080 -p 443:8443 -e HTTPPORT="8080" -e HTTPSPort="8443" --name aditomobile -t adito/aditomobile

## Env

HTTPPORT - http port inside container, default is 8080  
HTTPSPORT - https port inside container, default is 8443 
APIURL - URL to API of ADITO Server 
APIUSER - User for API of ADITO Server 
APIPW - User password
APICONFIG - Path to configuration

## docker-compose

```
mobile:
  image: adito/aditomobile
  ports:
   - "8443:8441"
   - "8080:8082"
  environment:
    - APIURL=http://adito:7934/run-process?wsdl
    - APIUSER=muser
    - HTTPPORT=8082
    - HTTPSPORT=8441
    - APIPW=a
  links:
    - adito
  restart: unless-stopped
```
