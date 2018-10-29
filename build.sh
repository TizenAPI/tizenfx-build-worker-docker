#!/bin/bash

SCRIPT_FILE=$(readlink -f $0)
SCRIPT_DIR=$(dirname $SCRIPT_FILE)

sudo docker build -t tizenfx-build-worker \
	--build-arg http_proxy=$http_proxy \
	--build-arg https_proxy=$https_proxy \
	$SCRIPT_DIR
