#!/bin/bash

docker image rm johnreah/radius
docker build -t johnreah/radius -f Dockerfile .
