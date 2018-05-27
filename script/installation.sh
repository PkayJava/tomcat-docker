#!/bin/sh

apt-get update

apt-get install -y --no-install-recommends build-essential libssl-dev libexpat1-dev ca-certificates wget nano curl libcap-dev

JAVA_HOME=/opt/jdk1.8.0_172
TOMCAT_HOME=/opt/tomcat-9.0.8

# APR
if [ -e /apps/apr-1.6.3.tar.gz ]
then
    cd /tmp && cp /apps/apr-1.6.3.tar.gz /tmp
else
    cd /tmp && wget http://www.eu.apache.org/dist/apr/apr-1.6.3.tar.gz
fi
cd /tmp && tar -zxvf apr-1.6.3.tar.gz && cd apr-1.6.3 && ./configure && make && make install

# JDK
if [ -e /apps/jdk-8u172-linux-x64.tar.gz ]
then
    cd /tmp && cp /apps/jdk-8u172-linux-x64.tar.gz /tmp
else
    cd /tmp && wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u172-b11/a58eab1ec242421181065cdc37240b08/jdk-8u172-linux-x64.tar.gz"
fi
cd /tmp && tar -zxvf jdk-8u172-linux-x64.tar.gz && rm -rf $JAVA_HOME && mv jdk1.8.0_172 $JAVA_HOME

# Apache Tomcat Native
if [ -e /apps/tomcat-native-1.2.16-src.tar.gz ]
then
    cd /tmp && cp /apps/tomcat-native-1.2.16-src.tar.gz /tmp
else
    cd /tmp && wget http://www-eu.apache.org/dist/tomcat/tomcat-connectors/native/1.2.16/source/tomcat-native-1.2.16-src.tar.gz
fi
cd /tmp && tar -zxvf tomcat-native-1.2.16-src.tar.gz && cd tomcat-native-1.2.16-src/native && ./configure --with-apr=/usr/local/apr/bin/apr-1-config --with-java-home=$JAVA_HOME --with-ssl=yes --prefix=/usr && make && make install

# Apache Tomcat
if [ -e /apps/apache-tomcat-9.0.8.tar.gz ]
then
    cd /tmp && cp /apps/apache-tomcat-9.0.8.tar.gz /tmp
else
    cd /tmp && wget http://www-eu.apache.org/dist/tomcat/tomcat-9/v9.0.8/bin/apache-tomcat-9.0.8.tar.gz
fi
cd /tmp && tar -zxvf apache-tomcat-9.0.8.tar.gz && rm -rf $TOMCAT_HOME && mv apache-tomcat-9.0.8 $TOMCAT_HOME
cp /apps/tomcat-9.0.8/conf/server.xml $TOMCAT_HOME/conf/server.xml
cp /apps/tomcat-9.0.8/bin/setenv.sh $TOMCAT_HOME/bin && chmod +x $TOMCAT_HOME/bin/setenv.sh

# OpenSSL
if [ -e /apps/openssl-1.1.1-pre6.tar.gz ]
then
    cd /tmp && cp /apps/openssl-1.1.1-pre6.tar.gz /tmp
else
    cd /tmp && wget https://www.openssl.org/source/openssl-1.1.1-pre6.tar.gz
fi

cd /tmp && rm -rf openssl-1.1.1-pre6 && tar -zxvf openssl-1.1.1-pre6.tar.gz && cd openssl-1.1.1-pre6
./config
./Configure
make depend && make all && make install

cd /tmp && rm -rf openssl-1.1.1-pre6 && tar -zxvf openssl-1.1.1-pre6.tar.gz && cd openssl-1.1.1-pre6
./config no-shared
./Configure
make depend && make all && make install

ldconfig

# CA
cp -r /apps/openssl /opt/openssl

# java
cp -r /apps/java /opt/java

# jsvc
if [ -e /apps/commons-daemon-1.1.0-native-src.tar.gz ]
then
    cd /tmp && cp /apps/commons-daemon-1.1.0-native-src.tar.gz /tmp
else
    cd /tmp && wget http://www-eu.apache.org/dist/commons/daemon/source/commons-daemon-1.1.0-native-src.tar.gz
fi
cd /tmp && tar -zxvf commons-daemon-1.1.0-native-src.tar.gz && cd commons-daemon-1.1.0-native-src/unix && ./configure --with-java=$JAVA_HOME && make && cp jsvc $TOMCAT_HOME/bin
