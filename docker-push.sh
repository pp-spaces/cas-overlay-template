#!/bin/bash

DOCKER_ORG=${DOCKER_ORG:-org.apereo.cas}
DOCKER_AUTH_USER=${DOCKER_AUTH_USER}
DOCKER_AUTH_PASSWORD=${DOCKER_AUTH_PASSWORD}

IMAGE_NAME="$DOCKER_ORG/cas"
IMAGE_VERSION=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

IMAGE_TAG="$IMAGE_NAME:$IMAGE_VERSION"

echo "Authenticating to Docker Hub..."
echo "$DOCKER_AUTH_PASSWORD" | docker login --username "$DOCKER_AUTH_USER" --password-stdin

echo "Pushing CAS docker image tagged as $IMAGE_VERSION to $IMAGE_NAME..."
docker push "$IMAGE_TAG" \
	&& echo "Pushed $IMAGE_TAG successfully.";
