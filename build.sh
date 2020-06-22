#!/bin/bash

SCRIPT_FILE=$(readlink -f $0)
SCRIPT_DIR=$(dirname $SCRIPT_FILE)

NAME=tizendotnet/tizenfx-build-worker
TAG=latest

if [ ! -z $1 ]; then
  TAG=$1
fi

docker build --tag $NAME:$TAG $SCRIPT_DIR
