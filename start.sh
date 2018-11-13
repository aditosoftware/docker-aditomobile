#!/bin/bash

cat > /usr/local/tomcat/conf/server.xml << EOF
<?xml version="1.0" encoding="UTF-8"?>
<Server port="-1" shutdown="SHUTDOWN">
  <Listener className="org.apache.catalina.startup.VersionLoggerListener" />
  <Listener className="org.apache.catalina.core.AprLifecycleListener" SSLEngine="on" />
  <Listener className="org.apache.catalina.core.JreMemoryLeakPreventionListener" />
  <Listener className="org.apache.catalina.mbeans.GlobalResourcesLifecycleListener" />
  <Listener className="org.apache.catalina.core.ThreadLocalLeakPreventionListener" />

  <GlobalNamingResources>
    <Resource name="UserDatabase" auth="Container"
              type="org.apache.catalina.UserDatabase"
              description="User database that can be updated and saved"
              factory="org.apache.catalina.users.MemoryUserDatabaseFactory"
              pathname="conf/tomcat-users.xml" />
  </GlobalNamingResources>

  <Service name="Catalina">

    <Connector port="${HTTPPORT:-8080}" protocol="HTTP/1.1"
               connectionTimeout="20000" />

    <Connector port="${HTTPSPORT:-8443}" protocol="org.apache.coyote.http11.Http11NioProtocol"
               maxThreads="150" SSLEnabled="true">
        <SSLHostConfig>
            <Certificate certificateKeystoreFile="conf/localhost-rsa.jks"
                         type="RSA" />
        </SSLHostConfig>
    </Connector>

    <Engine name="Catalina" defaultHost="localhost">
      <Realm className="org.apache.catalina.realm.LockOutRealm">
        <Realm className="org.apache.catalina.realm.UserDatabaseRealm"
               resourceName="UserDatabase"/>
      </Realm>
      <Host name="localhost"  appBase="webapps"
            unpackWARs="true" autoDeploy="true">
        <Valve className="org.apache.catalina.valves.AccessLogValve" directory="logs"
               prefix="localhost_access_log" suffix=".txt"
               pattern="%h %l %u %t &quot;%r&quot; %s %b" />

      </Host>
    </Engine>
  </Service>
</Server>

EOF

if [ ! -f /usr/local/tomcat/conf/localhost-rsa.jks ]; then
    $JAVA_HOME/bin/keytool -genkey -alias tomcat -dname "cn=ADITO, ou=ADITO, o=ADITO, c=DE" -keyalg RSA -storepass changeit -keypass changeit -keystore /usr/local/tomcat/conf/localhost-rsa.jks -storetype pkcs12
fi

echo "apiurl = ${APIURL}" > /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apiuser = ${APIUSER}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apipw = ${APIPW}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "apiconfig = ${APICONFIG:-}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop
echo "logserverrequests = ${LOGSERVERREQUESTS:-false}" >> /usr/local/tomcat/webapps/aditomobile/WEB-INF/classes/adito.prop

/usr/local/tomcat/bin/catalina.sh run