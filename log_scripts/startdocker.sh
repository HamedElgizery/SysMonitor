LOGGING_DIR=$PWD/loggging

if [ ! -d $LOGGING_DIR ]; then
  echo "Stopping previous container..."
  mkdir $LOGGING_DIR 
fi

if [ "$(sudo docker ps | grep sys_logging)" != "" ]; then
  sudo docker stop sys_logging
fi

sudo docker image build -t logging-image .

 sudo docker run --rm -dit --gpus all --privileged \
  --name sys_logging --mount \
  type=bind,src=/$PWD/logging,target=/logs logging-image 2>&1 || \
  echo "WARNING: Failed to detect GPU... Rerunning..." && sudo docker run --rm -dit \
  --privileged --name sys_logging --mount \
  type=bind,src=/$PWD/logging,target=/logs logging-image
