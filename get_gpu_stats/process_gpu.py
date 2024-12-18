#!/bin/python3
import csv
import io
from sys import argv

csv_data = argv[1]
csv_stream = io.StringIO(csv_data)

csv_reader = csv.DictReader(csv_stream)
for row in csv_reader:
    for col_heading, value in row.items():
        print(col_heading.strip().replace(" ", "-"), value.strip().replace(" ", ""))