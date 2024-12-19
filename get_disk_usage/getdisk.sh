#!/bin/bash

# Could be useful
# pushd /
df -h /. | awk '$1 != "Filesystem"'
# popd
