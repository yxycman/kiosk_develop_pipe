FROM openjdk:7
MAINTAINER "Oleksii Liashuk" <oleksii_liashuk@epam.com>
ARG BUILD_VERSION
ENV BUILD_VERSION ${BUILD_VERSION}
COPY HelloWorld/target/hello-world-0.1-SNAPSHOT.jar /opt
WORKDIR /opt
EXPOSE 9090
ENTRYPOINT ["java", "-jar", "/opt/hello-world-0.1-SNAPSHOT.jar"]