#!/bin/sh

apt-get update

apt-get install -y --no-install-recommends build-essential libssl-dev libexpat1-dev ca-certificates wget nano curl libcap-dev autoconf

JAVA_HOME=/opt/jdk1.8.0_292
TOMCAT_HOME=/opt/tomcat-9.0.46

# APR
if [ -e /apps/apr-1.7.0.tar.gz ]
then
    cd /tmp && cp /apps/apr-1.7.0.tar.gz /tmp
else
    cd /tmp && wget http://www.eu.apache.org/dist/apr/apr-1.7.0.tar.gz
fi
cd /tmp && tar -zxvf apr-1.7.0.tar.gz && cd apr-1.7.0 && ./configure && make && make install

# JDK
if [ -e /apps/zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz ]
then
    cd /tmp && cp /apps/zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz /tmp
else
    cd /tmp && wget --no-cookies --no-check-certificate "https://cdn.azul.com/zulu/bin/zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz"
fi
cd /tmp && tar -zxvf zulu8.54.0.21-ca-jdk8.0.292-linux_x64.tar.gz && rm -rf $JAVA_HOME && mv zulu8.54.0.21-ca-jdk8.0.292-linux_x64 $JAVA_HOME

# Apache Tomcat Native
if [ -e /apps/tomcat-native-1.2.30-src.tar.gz ]
then
    cd /tmp && cp /apps/tomcat-native-1.2.30-src.tar.gz /tmp
else
    cd /tmp && wget https://www-eu.apache.org/dist/tomcat/tomcat-connectors/native/1.2.30/source/tomcat-native-1.2.30-src.tar.gz
fi
cd /tmp && tar -zxvf tomcat-native-1.2.30-src.tar.gz && cd tomcat-native-1.2.30-src/native && ./configure --with-apr=/usr/local/apr/bin/apr-1-config --with-java-home=$JAVA_HOME --with-ssl=yes --prefix=/usr && make && make install

# Apache Tomcat
if [ -e /apps/apache-tomcat-9.0.46.tar.gz ]
then
    cd /tmp && cp /apps/apache-tomcat-9.0.46.tar.gz /tmp
else
    cd /tmp && wget https://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.46/bin/apache-tomcat-9.0.46.tar.gz
fi
cd /tmp && tar -zxvf apache-tomcat-9.0.46.tar.gz && rm -rf $TOMCAT_HOME && mv apache-tomcat-9.0.46 $TOMCAT_HOME
cp /apps/tomcat-9.0.46/conf/server.xml $TOMCAT_HOME/conf/server.xml
cp /apps/tomcat-9.0.46/bin/setenv.sh $TOMCAT_HOME/bin && chmod +x $TOMCAT_HOME/bin/setenv.sh

# CA
cp -r /apps/openssl /opt/openssl

# java
cp -r /apps/java /opt/java

# jsvc
if [ -e /apps/commons-daemon-1.2.4-src.tar.gz ]
then
    cd /tmp && cp /apps/commons-daemon-1.2.4-src.tar.gz /tmp
else
    cd /tmp && wget https://www-eu.apache.org/dist/commons/daemon/source/commons-daemon-1.2.4-src.tar.gz
fi
cd /tmp && tar -zxvf commons-daemon-1.2.4-src.tar.gz && cd commons-daemon-1.2.4-src/unix && ./configure --with-java=$JAVA_HOME && make && cp jsvc $TOMCAT_HOME/bin
