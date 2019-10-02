#!/bin/bash

image_org=${DOCKER_ORG:-org.apereo.cas}
image_version=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)
image_tag="$image_org/cas:$image_tag"

echo "Building CAS docker image tagged as [$image_tag]"
# read -p "Press [Enter] to continue..." any_key;

docker build --tag="$image_tag" . \
  && echo "Built CAS image successfully tagged as $image_tag" \
  && docker images "$image_tag"
