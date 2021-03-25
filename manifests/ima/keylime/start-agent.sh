#!/usr/bin/env bash

IMAGE_NAME=stefanberger/keylime_agent:latest

systemctl start docker
systemctl enable docker

docker login -u stefanberger
#if [ $? -ne 0 ]; then
#	exit 1
#fi
docker pull ${IMAGE_NAME}
if [ $? -ne 0 ]; then
	exit 1
fi

REGISTRAR_IP=192.168.122.200
CLOUDAGENT_IP=0.0.0.0
docker run --env REGISTRAR_IP=${REGISTRAR_IP} --env CLOUDAGENT_IP=${CLOUDAGENT_IP} \
    --env AGENT_UUID=D432FBB3-D2F1-4A97-9EF7-75BD81C00000 --device=/dev/tpm0 \
    -v /sys/kernel/security:/sys/kernel/security --privileged \
    --rm --network host ${IMAGE_NAME}
