# Apache Tomcat v9.0.8
# OpenSSL v1.1.1-pre6
# libtcnative v1.2.16
# Apache Portable Runtime v1.6.3
# jsvc v1.1.0
# Oracle JDK v8u172
# 1WaySSL + 2WaySSL + Java NIO2 (HTTP/HTTPS/AJP)

# Build Docker Image
:/>docker build -t localhost:5000/tomcat:9.0 .

# Docker Run
:/>docker run -v /opt/java:/opt/tomcat-9.0.8/webapps -p 8443:8443 -p 8444:8444 -p 8080:8080 -p 8009:8009 -p 8005:8005 -it -d --name tomcat9.0 localhost:5000/tomcat:9.0

