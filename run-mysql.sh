#!/bin/bash

CONTAINER_NAME='radius-mysql'

echo "Stopping existing container..."
docker stop $CONTAINER_NAME
echo "Removing existing container..."
docker rm $CONTAINER_NAME

echo "Starting new container..."
docker run \
    --detach \
    --name $CONTAINER_NAME \
    -p 3306:3306 \
    -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
    --network=radius-net \
    johnreah/radius-mysql

docker logs -f $CONTAINER_NAME
