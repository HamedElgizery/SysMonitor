#!/bin/bash

./process_net.py "$(ip -s -j link)" > output.txt
