#!/bin/bash

# Build image from Dockerfile
docker build -t kafka_node:v1.0 .

#
docker run -tid --name node1 kafka_node:v1.0
