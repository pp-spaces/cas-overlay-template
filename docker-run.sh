#!/bin/bash

DOCKER_ORG=${DOCKER_ORG:-org.apereo.cas}

IMAGE_NAME="$DOCKER_ORG/cas"
IMAGE_VERSION=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

IMAGE_TAG="$IMAGE_NAME:$IMAGE_VERSION"

echo "Cleaning up existing container..."
docker stop cas > /dev/null 2>&1
docker rm cas > /dev/null 2>&1

echo "Running new CAS container..."
docker run -d -p 8080:8080 -p 8443:8443 --name="cas" $IMAGE_TAG \
    && docker logs -f cas
