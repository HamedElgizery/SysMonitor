#!/bin/bash

# Need lm-sensor installed 
# sudo apt install lm-sensors
# Need to scan the sensors after
# sudo sensors-detect

 sensors | awk '$1 == "Core" {print $3}' > cpu_temp.txt
