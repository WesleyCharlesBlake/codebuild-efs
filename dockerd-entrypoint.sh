#!/bin/bash
set -e

/usr/bin/dockerd  \
	--data-root=/efs \
	--storage-driver=overlay2 &>/var/log/docker.log &