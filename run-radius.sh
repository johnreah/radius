#!/bin/bash

CONTAINER_NAME='radius-radius'

echo "Stopping existing container..."
docker stop $CONTAINER_NAME
echo "Removing existing container..."
docker rm $CONTAINER_NAME

echo "Starting new container..."
docker run \
    --detach \
    --name $CONTAINER_NAME \
    -p 1812-1813:1812-1813/udp \
    --network=radius-net \
    johnreah/radius -X

docker logs -f $CONTAINER_NAME
