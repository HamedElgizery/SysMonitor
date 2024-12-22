if [ "$(sudo docker ps | grep sys_stats)" != "" ]; then
  echo "Stopping previous container..."
  sudo docker stop sys_stats
fi

sudo docker image build -t scripts .

  sudo docker run --rm -dit --gpus all --privileged \
    --name sys_stats --network host scripts || \
  echo "WARNING: Failed to detect GPU... Rerunning..." && sudo docker run --rm -dit --privileged \
  --name sys_stats --network host scripts
