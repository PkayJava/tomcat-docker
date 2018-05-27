FROM ubuntu:18.04

MAINTAINER Socheat KHAUV pkayjava@gmail.com

ENV JAVA_HOME /opt/jdk1.8.0_172

COPY script /script

COPY apps /apps

RUN /script/installation.sh

EXPOSE 8080
EXPOSE 8443
EXPOSE 8444
EXPOSE 8009
EXPOSE 9080
EXPOSE 9443
EXPOSE 9444
EXPOSE 9009
EXPOSE 7005

CMD ["/opt/tomcat-9.0.8/bin/catalina.sh","run"]

