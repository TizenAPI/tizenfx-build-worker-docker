#!/bin/bash

SCRIPT_FILE=$(readlink -f $0)
SCRIPT_DIR=$(dirname $SCRIPT_FILE)

NAME=tizendotnet/tizenfx-build-worker

docker build -t $NAME $SCRIPT_DIR
