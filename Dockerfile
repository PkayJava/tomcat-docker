FROM localhost:5000/ubuntu:18.04

MAINTAINER Socheat KHAUV pkayjava@gmail.com

ENV JAVA_HOME /opt/jdk1.8.0_172

COPY script /script

COPY apps /apps

RUN /script/installation.sh

EXPOSE 8080
EXPOSE 8443
EXPOSE 8444
EXPOSE 8009
EXPOSE 8005

CMD ["/opt/tomcat-9.0.8/bin/catalina.sh","run"]
