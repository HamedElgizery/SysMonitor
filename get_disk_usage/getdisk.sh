#!/bin/bash

# Could be useful
# pushd /
df -h /. | awk '$1 != "Filesystem"' > disk_usage.txt
# popd
