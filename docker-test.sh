#!/bin/bash

export DOCKER_ORG=ppspaces

DOCKER_ORG=${DOCKER_ORG:-org.apereo.cas}

IMAGE_NAME="$DOCKER_ORG/cas"
IMAGE_VERSION=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)

IMAGE_TAG="$IMAGE_NAME:$IMAGE_VERSION"

# Cleaning up
./docker-clean.sh

# Rebuild images
./docker-build.sh

# Running images
./docker-run.sh
