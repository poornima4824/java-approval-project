# Pull base image 
From tomcat:8-jre8 

COPY ./webapp/target/maven-project*.war /usr/local/tomcat/webapps/maven-project
