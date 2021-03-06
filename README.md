# Features
- Apache Tomcat v9.0.46
- libtcnative v1.2.30
- Apache Portable Runtime v1.7.0
- jsvc v1.2.4
- jdk1.8.0_292
- 1WaySSL + 2WaySSL + Java NIO2 (HTTP/HTTPS/AJP)

# NIO2 Port
- 8080 - HTTP
- 8443 - 1Way HTTPS
- 8444 - 2Way HTTPS
- 8009 - AJP

# APR Port
- 9080 - HTTP
- 9443 - 1Way HTTPS
- 9444 - 2Way HTTPS
- 9009 - AJP

# Shutdown Port
- 7005

# Build Docker Image
:/>docker build -t localhost:5000/tomcat:9.0 .

# Docker Run (NIO2)
:/>docker run -v /opt/java:/opt/java/localhost -p 8443:8443 -p 8444:8444 -p 8080:8080 -p 8009:8009 -p 7005:7005 -it -d --name tomcat9.0 localhost:5000/tomcat:9.0

# Docker Run (APR)
:/>docker run -v /opt/java:/opt/java/localhost -p 9443:9443 -p 9444:9444 -p 9080:9080 -p 9009:9009 -p 7005:7005 -it -d --name tomcat9.0 localhost:5000/tomcat:9.0

# Docker Stop
:/>docker stop tomcat9.0

# Docker Start
:/>docker start tomcat9.0

# Docker Remove
:/>docker rm tomcat9.0

# War(s)
- replace /opt/java according to your preference