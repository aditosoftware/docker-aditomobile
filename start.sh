#!/bin/bash
sed -i '87s/<!--/ /' /usr/local/tomcat/conf/server.xml
sed -i '95s/-->/ /' /usr/local/tomcat/conf/server.xml

$JAVA_HOME/bin/keytool -genkey -alias tomcat -dname "cn=ADITO, ou=ADITO, o=ADITO, c=DE" -keyalg RSA -storepass changeit -keypass changeit -keystore /usr/local/tomcat/conf/localhost-rsa.jks -storetype pkcs12

echo "apiurl = ${APIURL}" > /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apiuser = ${APIUSER}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apipw = ${APIPW}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apiconfig = ${APICONFIG:-}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "logserverrequests = ${LOGSERVERREQUESTS:-false}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop

/usr/local/tomcat/bin/catalina.sh run