#!/bin/python3

import json
from sys import argv
import time

network_stats_json = argv[1]
time_now = time.strftime("%Y-%m-%d %H:%M:%S")  

stats = json.loads(network_stats_json)
for interface in stats:
    payload_lines = [time_now]
    if_name = interface.get('ifname', "unknown")
    stats = interface.get('stats64', "") 

    rx = stats.get('rx', {})
    tx = stats.get('tx', {})
    payload_lines.append(if_name)

    for value in rx.values():
        payload_lines.append(value)

    for value in tx.values():
        payload_lines.append(value)

    print(",".join(str(item) for item in payload_lines))