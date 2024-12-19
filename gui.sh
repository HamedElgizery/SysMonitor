#!/bin/bash

while true; do
  # Create a Zenity list dialog with options
  selection=$(zenity --list \
    --title="System Performance Options" \
    --text="Choose an option to view more details:" \
    --width=600 \
    --height=400 \
    --column="Performance Metric" --column="Action" \
    "CPU Performance" "Open" \
    "GPU Performance" "Open" \
    "Disk Usage" "Open" \
    "Memory Usage" "Open" \
    "Network Stats" "Open" \
    "System Load" "Open")

  if [ "$selection" == "CPU Performance" ]; then
    while true; do
      if [ -f "get_cpu_perf/getcpu.sh" ]; then
        output=$(bash get_cpu_perf/getcpu.sh)

        rows=""
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          rows+="$key $value "
        done <<< "$output"

        response=$(zenity --list \
          --title="CPU Performance Details" \
          --text="CPU Performance metrics:" \
          --width=600 \
          --height=400 \
          --column="Metric" --column="Value" \
          $rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_cpu_perf/getcpu.sh was not found."
        break
      fi
      sleep 3
    done

  elif [ "$selection" == "GPU Performance" ]; then
    while true; do
      if [ -f "get_gpu_stats/getgpu.sh" ]; then
        gpu_output=$(bash get_gpu_stats/getgpu.sh)

        gpu_rows=""
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          gpu_rows+="$key $value "
        done <<< "$gpu_output"

        response=$(zenity --list \
          --title="GPU Performance Details" \
          --text="GPU Performance metrics:" \
          --width=600 \
          --height=400 \
          --column="Metric" --column="Value" \
          $gpu_rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_gpu_stats/getgpu.sh was not found."
        break
      fi
      sleep 3
    done

  elif [ "$selection" == "Disk Usage" ]; then
    while true; do
      if [ -f "get_disk_usage/getdisk.sh" ]; then
        disk_output=$(bash get_disk_usage/getdisk.sh)

        disk_rows=""
        while IFS= read -r line; do
          disk_name=$(echo "$line" | awk '{print $1}')
          total_space=$(echo "$line" | awk '{print $2}')
          used_space=$(echo "$line" | awk '{print $3}')
          available_space=$(echo "$line" | awk '{print $4}')
          used_precentage=$(echo "$line" | awk '{print $5}')

          disk_rows+="$disk_name $total_space $used_space $available_space $used_precentage "
        done <<< "$disk_output"

        response=$(zenity --list \
          --title="Disk Usage Details" \
          --text="Disk Usage metrics:" \
          --width=600 \
          --height=400 \
          --column="Disk Name" --column="Total Space" --column="Used Space" \
          --column="Available Space" --column="Used Percentage" \
          $disk_rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_disk_usage/getdisk.sh was not found."
        break
      fi
      sleep 3
    done

  elif [ "$selection" == "Memory Usage" ]; then
    while true; do
      if [ -f "get_memory_usage/getmem.sh" ]; then
        mem_output=$(bash get_memory_usage/getmem.sh)

        mem_rows=""
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          mem_rows+="$key $value "
        done <<< "$mem_output"

        response=$(zenity --list \
          --title="Memory Usage Details" \
          --text="Memory Usage metrics:" \
          --width=600 \
          --height=400 \
          --column="Metric" --column="Value" \
          $mem_rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_memory_usage/getmem.sh was not found."
        break
      fi
      sleep 3
    done

  elif [ "$selection" == "Network Stats" ]; then
    while true; do
      if [ -f "get_net_stats/getnet.sh" ]; then
        net_output=$(bash get_net_stats/getnet.sh)

        net_rows=""
        while IFS= read -r line; do
          if_name=$(echo "$line" | awk '{print $1}')
          rx_bytes=$(echo "$line" | awk '{print $2}')
          rx_packets=$(echo "$line" | awk '{print $3}')
          rx_errors=$(echo "$line" | awk '{print $4}')
          rx_dropped=$(echo "$line" | awk '{print $5}')
          rx_over_errors=$(echo "$line" | awk '{print $6}')
          rx_multicast=$(echo "$line" | awk '{print $7}')
          tx_bytes=$(echo "$line" | awk '{print $8}')
          tx_packets=$(echo "$line" | awk '{print $9}')
          tx_errors=$(echo "$line" | awk '{print $10}')
          tx_dropped=$(echo "$line" | awk '{print $11}')
          tx_carrier_errors=$(echo "$line" | awk '{print $12}')
          tx_collisions=$(echo "$line" | awk '{print $13}')

          net_rows+="$if_name $rx_bytes $rx_packets $rx_errors $rx_dropped $rx_over_errors $rx_multicast $tx_bytes $tx_packets $tx_errors $tx_dropped $tx_carrier_errors $tx_collisions "
        done <<< "$net_output"

        response=$(zenity --list \
          --title="Network Statistics" \
          --text="Network interface statistics:" \
          --width=800 \
          --height=400 \
          --column="Interface" --column="RX Bytes" --column="RX Packets" --column="RX Errors" \
          --column="RX Dropped" --column="RX Over Errors" --column="RX Multicast" \
          --column="TX Bytes" --column="TX Packets" --column="TX Errors" \
          --column="TX Dropped" --column="TX Carrier Errors" --column="TX Collisions" \
          $net_rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_net_stats/getnet.sh was not found."
        break
      fi
      sleep 3
    done
  else
    break
  fi

  sleep 3
done
