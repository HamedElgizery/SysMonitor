#!/bin/python3
import json
from sys import argv

mpstat_data = json.loads(argv[1])
print(mpstat_data)
