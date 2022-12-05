#!/bin/bash

docker volume rm radius_radius-mysql-volume
docker image rm johnreah/radius-mysql
docker build -t johnreah/radius-mysql -f Dockerfile-mysql .
