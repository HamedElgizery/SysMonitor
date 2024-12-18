#!/bin/python3
import json
from sys import argv

mpstat_data = json.loads(argv[1])


cpu_stats = mpstat_data['sysstat']['hosts'][0]['statistics'][0]['cpu-load'][0]
for key, value in cpu_stats.items():
    print(key, value)