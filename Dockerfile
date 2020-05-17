FROM ubuntu:latest
MAINTAINER geoffroy

# Install vim, wget, gpg and java
RUN apt-get update
RUN apt-get install -y vim wget gpg iputils-ping telnet python3 python3-pip default-jre default-jdk
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# create user and directories
RUN useradd kafka --create-home

# download and install kafka
WORKDIR /tmp
RUN wget -P /tmp/ https://miroir.univ-lorraine.fr/apache/kafka/2.5.0/kafka_2.12-2.5.0.tgz
RUN wget -P /tmp/ https://dist.apache.org/repos/dist/release/kafka/2.5.0/kafka_2.12-2.5.0.tgz.md5
RUN echo CHECKSUM VERIFICATION :

RUN gpg --print-md MD5 kafka_2.12-2.5.0.tgz
RUN cat kafka_2.12-2.5.0.tgz.md5
RUN mkdir kafka && tar -xzf kafka_2.12-2.5.0.tgz -C kafka --strip-components 1
RUN cp -r kafka /home/kafka/ && rm -r *

# build default configuration
RUN rm /home/kafka/kafka/config/server.properties
RUN echo "broker.id=0" >> /home/kafka/kafka/config/server.properties
RUN echo "listeners=PLAINTEXT://:9092" >> /home/kafka/kafka/config/server.properties
RUN echo "advertised.listeners=PLAINTEXT://:9092" >> /home/kafka/kafka/config/server.properties
RUN echo "delete.topic.enable=true" >> /home/kafka/kafka/config/server.properties
RUN echo "log.dirs=/tmp/kafka-logs" >> /home/kafka/kafka/config/server.properties
RUN echo "num.partitions=1" >> /home/kafka/kafka/config/server.properties
RUN echo "log.retention.hours=168" >> /home/kafka/kafka/config/server.properties
RUN echo "log.segment.bytes=1073741824" >> /home/kafka/kafka/config/server.properties
RUN echo "log.retention.check.interval.ms=300000" >> /home/kafka/kafka/config/server.properties
RUN echo "zookeeper.connect=localhost:2181" >> /home/kafka/kafka/config/server.properties
RUN echo "zookeeper.connection.timeout.ms=6000" >> /home/kafka/kafka/config/server.properties
RUN echo "offsets.topic.replication.factor=1" >> /home/kafka/kafka/config/server.properties

WORKDIR /home/kafka
