#!/bin/python3
import csv
import io
from sys import argv

csv_data = argv[1]
csv_stream = io.StringIO(csv_data)

csv_reader = csv.DictReader(csv_stream)
for row in csv_reader:
    for i, (col_heading, col_value) in enumerate(row.items()):
        col_heading = col_heading.strip().replace(" ", "-")
        col_value = col_value.strip()

        if i == 0: # first case is the gpu name
            col_value = col_value.replace(" ", "-")
        elif "temperature" in col_heading:
            col_value += "°C"
        elif col_value.endswith("%"):
            col_value = col_value.replace(" ", "")
        else:
            col_value = col_value.replace(" ", "")

        print(col_heading, col_value)