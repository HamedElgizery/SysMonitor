#!/bin/bash

LOG_DIR="/scripts"

while true; do
  for dir in log*/; do
      if [ -d "$dir" ]; then
        for script in "$dir"*.sh; do
            if [ -f "$script" ]; then
                bash "$script" >> /logs/logoutput.txt
            fi
        done
      fi
    done
  sleep 10
done

