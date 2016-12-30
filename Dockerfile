# +++++++++++++++++++++++++++++++++++++++++
# Apache Tomcat 8 Dockerfile		  +
# @Author Muhammad Nasir Akram		  +
# Dated 30/12/2016
# +++++++++++++++++++++++++++++++++++++++++

FROM centos:latest
MAINTAINER mnakram1440@gmail.com

ENV TOMCAT_START no

# Update the system
RUN yum update -y

# Download the wget package
RUN yum install -y wget

# Change the working directory
WORKDIR "/opt/"

# Download the java package
RUN wget --no-cookies \
	 --no-check-certificate \
	 --header "Cookie: oraclelicense=accept-securebackup-cookie" \
	 http://download.oracle.com/otn-pub/java/jdk/8u111-b14/jdk-8u111-linux-x64.tar.gz

# Rename and extract the package
RUN tar -xzvf jdk-8u111-linux-x64.tar.gz
RUN mv jdk1.8.0_111 jdk8

# Create the links
RUN alternatives --install /usr/bin/java java /opt/jdk8/bin/java 2
RUN alternatives --install /usr/bin/jar jar /opt/jdk8/bin/jar 2
RUN alternatives --install /usr/bin/javac javac /opt/jdk8/bin/javac 2

RUN alternatives --set java /opt/jdk8/bin/java
RUN alternatives --set javac /opt/jdk8/bin/javac
RUN alternatives --set jar /opt/jdk8/bin/jar

# Download and extract tomcat8
RUN wget http://www-us.apache.org/dist/tomcat/tomcat-8/v8.5.9/bin/apache-tomcat-8.5.9.tar.gz
RUN tar -xzvf apache-tomcat-8.5.9.tar.gz
RUN mv apache-tomcat-8.5.9 tomcat8

# Export Environment Variables
RUN echo 'CATALINA_BASE=/opt/tomcat8' >> /etc/profile
RUN echo 'CATALINA_HOME=/opt/tomcat8' >> /etc/profile
RUN echo 'CATALINA_TMPDIR=/opt/tomcat8/temp' >> /etc/profile
RUN echo 'JAVA_HOME=/opt/jdk8' >> /etc/profile
RUN echo 'JRE_HOME=/opt/jdk8' >> /etc/profile

# Copy the entrypoint file
COPY entry-point.sh /entry-point.sh

# Remove the images
RUN rm -rf /opt/apache-tomcat-8.5.9.tar.gz
RUN rm -rf /opt/jdk-8u111-linux-x64.tar.gz

# Change the pwd
WORKDIR /

# Expose port 8080
EXPOSE 8080

ENTRYPOINT ["/entry-point.sh"]
