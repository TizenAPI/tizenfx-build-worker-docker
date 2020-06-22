#!/bin/bash

NAME=tizendotnet/tizenfx-build-worker

if [ $# -lt 2 ]; then
  echo "./run.sh [TAG] [WORKSPACE]"
  exit 1
fi

docker run -it -v $2:/home/jenkins/workspace/ $NAME:$1 /bin/bash

