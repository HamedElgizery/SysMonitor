#/bin/bash

sudo docker stop reporting
sudo docker image build -f dockerfile.report -t report-image .
sudo docker run --rm  --privileged --name reporting --mount type=bind,src=/home/hamed/src/SysMonitor/logging,target=/logs,readonly --mount type=bind,src=/home/hamed/src/SysMonitor/md_reporting/reports,target=/reports report-image

