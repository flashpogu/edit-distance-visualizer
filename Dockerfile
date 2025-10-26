FROM tomcat:9.0-jdk17-temurin


RUN rm -rf /usr/local/tomcat/webapps/*

# Disable Shutdown Port so health checks won't warn
RUN sed -i 's/port="8005"/port="-1"/' /usr/local/tomcat/conf/server.xml


COPY . /usr/local/tomcat/webapps/ROOT/


EXPOSE 8080


CMD ["catalina.sh", "run"]
