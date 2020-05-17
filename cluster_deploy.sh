#!/bin/bash

# create network
docker network create -d bridge --attachable kafka-net

# run zookeeper and zkui
docker run -d --name zookeeper --net=kafka-net -p 2181:2181 -e ALLOW_ANONYMOUS_LOGIN=yes zookeeper:3.5
#
docker run -tid --name node1 --net=kafka-net -p 9062:9062 kafka_node:v1.0
