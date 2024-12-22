REPORTS_DIR=$PWD/reports
LOGS_DIR=$PWD/../log_scripts/logging

if [ ! -d $REPORTS_DIR ]; then
  mkdir $REPORTS_DIR 
fi

if [ "$(sudo docker ps | grep sys_reporting)" != "" ]; then
  echo "Stopping previous container..."
  sudo docker stop sys_reporting
fi

sudo docker image build -t reporting-image .

  sudo docker run --rm -dit --gpus all --privileged \
    --name sys_reporting --network host --mount \
    type=bind,src=$REPORTS_DIR,target=/reports \
    --mount type=bind,src=$LOGS_DIR,target=/logs,ro reporting-image || \
  echo "WARNING: Failed to detect GPU... Rerunning..." && sudo docker run --rm -dit --privileged \
    --name sys_reporting --network host --mount \
    type=bind,src=$REPORTS_DIR,target=/reports \
    --mount type=bind,src=$LOGS_DIR,target=/logs,ro reporting-image 
