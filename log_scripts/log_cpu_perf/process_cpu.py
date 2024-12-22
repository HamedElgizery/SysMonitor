#!/bin/python3
import json
from sys import argv
import time

mpstat_data = json.loads(argv[1])
log_entry = [time.strftime("%Y-%m-%d %H:%M:%S")]  

cpu_stats = mpstat_data['sysstat']['hosts'][0]['statistics'][0]['cpu-load'][0]
for key, value in cpu_stats.items():
    if key == "cpu":
        continue
    log_entry.append(value)

print(",".join(str(item) for item in log_entry))
