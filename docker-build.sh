#!/bin/bash

DOCKER_ORG=${DOCKER_ORG:-org.apereo.cas}

IMAGE_NAME="$DOCKER_ORG/cas"
IMAGE_VERSION=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

IMAGE_TAG="$IMAGE_NAME:$IMAGE_VERSION"

echo "Building CAS docker image tagged as [$image_tag]"

docker build --tag="$IMAGE_TAG" . \
  && echo "Built CAS image successfully tagged as $IMAGE_TAG" \
  && echo "Available images:" \
  && docker images "$IMAGE_TAG"

# Build Latest release if CAS version is not Release Candidate
if ! echo "$IMAGE_VERSION" | grep -q "RC"; then
  IMAGE_TAG="$IMAGE_NAME:latest"

  echo "Build latest release..."

  docker build --tag="$IMAGE_TAG" . \
  && echo "Built CAS image successfully tagged as $IMAGE_TAG" \
  && docker images "$IMAGE_TAG"
fi
