if [ "$(sudo docker ps | grep sys_reporting)" != "" ]; then
  echo "Stopping previous container..."
  sudo docker stop sys_reporting
fi

sudo docker image build -t reporting .

  sudo docker run --rm -dit --gpus all --privileged \
    --name sys_reporting --network host reporting || \
  echo "WARNING: Failed to detect GPU... Rerunning..." && sudo docker run --rm -dit --privileged \
  --name sys_reporting --network host reporting
