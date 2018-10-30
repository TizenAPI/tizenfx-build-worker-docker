#!/bin/bash

SCRIPT_FILE=$(readlink -f $0)
SCRIPT_DIR=$(dirname $SCRIPT_FILE)

NAME=tizendotnet/tizenfx-build-worker
TAG="1.0"

sudo docker build -t $NAME:$TAG $SCRIPT_DIR
