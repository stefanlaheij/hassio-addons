#ARG BUILD_FROM
#FROM $BUILD_FROM
FROM resin/rpi-raspbian:latest

RUN apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    > /etc/apt/sources.list.d/webupd8team-java.list && \
    echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" \
    >> /etc/apt/sources.list.d/webupd8team-java.list && \
    apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 && \
    echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections

# Install java before unifi so a controller update doesn't force
# a rebuild/redownload of java
ENV JAVA_INSTALLER_VERSION 8u144-1~webupd8~0
RUN apt-get update && apt-get install -y --no-install-recommends \
    oracle-java8-installer=${JAVA_INSTALLER_VERSION} \
    oracle-java8-set-default \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/cache/oracle-jdk8-installer
    
RUN echo 'deb http://www.ubnt.com/downloads/unifi/debian stable ubiquiti' | sudo tee -a /etc/apt/sources.list.d/ubnt.list > /dev/null && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv C0A52C50 && \
    apt-get update     && \
    apt-get install unifi -y && \
    echo 'ENABLE_MONGODB=no' | sudo tee -a /etc/mongodb.conf > /dev/null
    
RUN wget http://central.maven.org/maven2/org/xerial/snappy/snappy-java/1.1.4-M3/snappy-java-1.1.4-M3.jar && \
    mv snappy-java-1.1.4-M3.jar /usr/lib/unifi/lib/snappy-*

RUN ln -s /data /usr/lib/unifi/data

WORKDIR /data

ENTRYPOINT ["/usr/bin/java", "-Xmx256M", "-jar", "/usr/lib/unifi/lib/ace.jar"]

CMD ["start"]

EXPOSE 8080/tcp 8081/tcp 8443/tcp 8843/tcp 8880/tcp 3478/udp