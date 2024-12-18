#!/bin/bash

awk '/MemTotal|MemFree|Buffers|Cached|SwapTotal|SwapFree|Active|Inactive|Available|Slab|Committed_AS|HighTotal|HighFree/ {print substr($1, 1, length($1)-1), $2}' /proc/meminfo > output.txt