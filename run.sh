#!/bin/bash

docker run -d --name radius -p 1812-1813:1812-1813/udp johnreah/radius -X
