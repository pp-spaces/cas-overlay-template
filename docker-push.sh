#!/bin/bash

docker_user=${DOCKER_AUTH_USER}
docker_psw=${DOCKER_AUTH_PASSWORD}

echo "$docker_psw" | docker login --username "$docker_user" --password-stdin

image_org=${DOCKER_ORG:-org.apereo.cas}
image_version=(`cat gradle.properties | grep "cas.version" | cut -d= -f2`)
image_tag="$image_org/cas:$image_tag"

echo "Pushing CAS docker image tagged as $image_version to $image_org/cas..."
docker push "$image_tag" \
	&& echo "Pushed $image_tag successfully.";
