#!/bin/bash
set -e

/usr/bin/dockerd  \
	--data-root=/efs &>/var/log/docker.log &