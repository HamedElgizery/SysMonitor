#!/bin/bash

if [ "$(sudo docker ps | grep visualizer)" != "" ]; then
  echo "Stopping previous container..."
  sudo docker stop visualizer
fi

LOGS_DIR=$PWD/../log_scripts/logging

sudo docker image build -t web-server .
sudo docker run -dit --rm --name visualizer -p 3000:3000 -v $LOGS_DIR:/logs web-server
