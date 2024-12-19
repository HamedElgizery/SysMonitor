#!/bin/bash

# Need lm-sensor installed 
# sudo apt install lm-sensors
# Need to scan the sensors after
# sudo sensors-detect

sensors | awk '/Core/{print $1 "-" substr($2, 1, length($2)-1) " " $3}'

