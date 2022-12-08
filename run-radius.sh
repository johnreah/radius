#!/bin/bash

CONTAINER_NAME='radius-radius'

echo "Stopping existing container..."
docker stop $CONTAINER_NAME
echo "Removing existing container..."
docker rm $CONTAINER_NAME

echo "Starting new container..."
docker run \
    --name $CONTAINER_NAME \
    --detach \
    --publish 1812-1813:1812-1813/udp \
    --network=radius-net \
    --env RADIUS_DB_SERVER=$RADIUS_DB_SERVER \
    --env RADIUS_DB_USER=$RADIUS_DB_USER \
    --env RADIUS_DB_PASSWORD=$RADIUS_DB_PASSWORD \
    johnreah/radius -X

docker logs -f $CONTAINER_NAME
