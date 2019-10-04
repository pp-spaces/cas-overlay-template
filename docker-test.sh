#!/bin/bash

export DOCKER_ORG=ppspaces

image_org=${DOCKER_ORG:-org.apereo.cas}
image_version=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)
image_tag="$image_org/cas:$image_version"

docker stop cas > /dev/null 2>&1
docker rm cas > /dev/null 2>&1

./docker-build.sh

docker run -d -p 8080:8080 -p 8443:8443 --name="cas" $image_tag
docker logs -f cas
