FROM ubuntu:latest
MAINTAINER geoffroy
RUN apt-get update
RUN apt-get install -y vim wget default-jre default-jdk
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN mkdir /home/kafka
RUN wget -P /home/kafka/ https://downloads.apache.org/kafka/2.5.0/kafka_2.12-2.5.0.tgz
RUN tar -xzf /home/kafka/kafka_2.12-2.5.0.tgz -C /home/kafka/
