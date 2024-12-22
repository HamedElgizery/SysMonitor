#!/bin/python3

import json
from sys import argv

network_stats_json = argv[1]

stats = json.loads(network_stats_json)
for interface in stats:
    if_name = interface.get('ifname', "unknown")
    stats = interface.get('stats64', "") 

    rx = stats.get('rx', {})
    tx = stats.get('tx', {})
    payload = f"{if_name} "

    for value in rx.values():
        payload += f"{value} "

    for value in tx.values():
        payload += f"{value} "


    print(payload)
