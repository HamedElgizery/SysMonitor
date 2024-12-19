#!/bin/python3

import json
from sys import argv

network_stats_json = argv[1]


stats = json.loads(network_stats_json)
for interface in stats:
    print(interface['stats64'])

# for interface in stats:
#     iface_name = interface.get("ifname", "Unknown")
#     rx_stats = interface.get("stats", {}).get("rx_bytes", 0)
#     tx_stats = interface.get("stats", {}).get("tx_bytes", 0)
    
#     print(f"{iface_name} {rx_stats}-{tx_stats}")
