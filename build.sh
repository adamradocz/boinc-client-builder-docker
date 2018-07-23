#!/bin/bash
IMAGE_TAG="boinc-client-builder"

docker build -t $IMAGE_TAG .
ID=$(docker create $IMAGE_TAG)
docker cp $ID:/build/ .
docker rm -v $ID
docker rmi $IMAGE_TAG
