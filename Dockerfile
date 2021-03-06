FROM tomcat:9.0-jre8-alpine

ADD start.sh /start.sh

RUN chmod +x /start.sh \
 && apk add -q --no-cache curl \
 && rm -rf /usr/local/tomcat/webapps/* \
 && mkdir -p /usr/local/tomcat/webapps/aditomobile \
 && curl -s -o /tmp/aditomobile.war "https://files.weptun.de/index.php?action=show&what=file&hash=2fe1759df0.war" \
 && unzip -q /tmp/aditomobile.war -d /usr/local/tomcat/webapps/aditomobile \
 && rm -rf /tmp/*
 
 
CMD ["/start.sh"]

