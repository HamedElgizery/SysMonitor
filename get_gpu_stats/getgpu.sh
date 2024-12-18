#!/bin/bash

 ./process_gpu.py "$(nvidia-smi --query-gpu=gpu_name,utilization.gpu,utilization.memory,utilization.encoder,utilization.decoder,fan.speed,temperature.gpu,memory.total,memory.free,memory.used,power.draw,power.max_limit,clocks.sm,clocks.mem,clocks.gr,clocks.video --format=csv)" > output.txt
