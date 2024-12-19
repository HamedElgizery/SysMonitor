#!/bin/bash

while true; do
  #docker_call="sudo docker exec -it sys_stats"
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

        rows=$(printf "  Metric  Value  ")
        rows+='\n'
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          rows+=$(printf "  %-6s  %5.2f  " $key $value)
          rows+='\n'
        done <<< "$output"

        TERM=ansi whiptail --title "CPU Performance Details" \
          --infobox "$(printf "$rows")" 20 21 

        [ $? -eq 1 ] && break
        read -t 0.1 -r -s -N 1 && [[ $REPLY == 'q' ]] && break
      else
        zenity --error --text="The script get_cpu_perf/getcpu.sh was not found."
        break
      fi
    done
    clear

  elif [ "$selection" == "GPU Performance" ]; then
    while true; do
      if [ -f "get_gpu_stats/getgpu.sh" ]; then
        gpu_output=$(bash get_gpu_stats/getgpu.sh)

        # TODO: Handle errors and check type of GPU
        gpu_rows="Metric Value\n"
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          gpu_rows+="$key $value\n"
        done <<< "$gpu_output"

        TERM=ansi whiptail --title "GPU Performance Details" \
          --infobox "$gpu_rows" 30 52 

        [ $? -eq 1 ] && break
        read -t 0.1 -r -s -N 1 && [[ $REPLY == 'q' ]] && break
      else
        zenity --error --text="The script get_gpu_stats/getgpu.sh was not found."
        break
      fi
    done
    clear

  elif [ "$selection" == "Disk Usage" ]; then
    while true; do
      if [ -f "get_disk_usage/getdisk.sh" ]; then
        disk_output=$(bash get_disk_usage/getdisk.sh)

        disk_rows="$(printf "%15s | %15s | %15s | %15s | %15s | %15s" \
                    "Disk Name" "Totatl Space" "Used Space" "Free Space" "Used Percntage" "Smart Status"
                  )" 
        disk_rows+='\n'
        while IFS= read -r line; do
          disk_name=$(echo "$line" | awk '{print $1}')
          total_space=$(echo "$line" | awk '{print $2}')
          used_space=$(echo "$line" | awk '{print $3}')
          available_space=$(echo "$line" | awk '{print $4}')
          used_precentage=$(echo "$line" | awk '{print $5}')

          # Check if disk is a SMART Disk
          # TODO: Would it unintentionally eliminate partitions and some Disks in some cases?

          smart_line=$(sudo smartctl -H $disk_name | grep "INQUERY faild")
          if [ "$smart_line" != "" ]; then
            echo "Skipping $disk_name"
            continue
          fi
          smart_line=$(sudo smartctl -H $disk_name | grep "PASSED")
          smart_status=""
          if [ "$smart_line" != "" ]; then
            smart_status="PASSED"
          else
            smart_status="FAILED"
          fi
          
          disk_rows+="$(printf "%15s | %15s | %15s | %15s | %15s%% | %15s" $disk_name $total_space $used_space $available_space $used_precentage $smart_status)"
          disk_rows+='\n'
        done <<< "$disk_output"
        
        #TODO: Add verticle scroll bar
        TERM=ansi whiptail --title "Disk Usage Details" \
          --infobox "$(printf "$disk_rows")" 30 120

        [ $? -eq 1 ] && break
        read -t 0.1 -r -s -N 1 && [[ $REPLY == 'q' ]] && break
      else
        zenity --error --text="The script get_disk_usage/getdisk.sh was not found."
        break
      fi
    done
    clear

  elif [ "$selection" == "Memory Usage" ]; then
    while true; do
      if [ -f "get_memory_usage/getmem.sh" ]; then
        mem_output=$($docker_call "get_memory_usage/getmem.sh" | tr -d '\r')
        mem_rows=$(printf " %-14s %s " "Metric" "Value")
        mem_rows+='\n'
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          mem_rows+=$(printf " %-14s %d KB " $key $value)
          mem_rows+='\n'
        done <<< "$mem_output"

        TERM=ansi whiptail --title "Memory Usage" \
          --infobox "$(printf "$mem_rows")" 25 32

        [ $? -eq 1 ] && break
        read -t 0.1 -r -s -N 1 && [[ $REPLY == 'q' ]] && break
      else
        zenity --error --text="The script get_memory_usage/getmem.sh was not found."
        break
      fi
    done
    clear

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

  elif [ "$selection" == "System Load" ]; then
    while true; do
      if [ -f "get_sys_load/getload.sh" ]; then
        sys_output=$(bash get_sys_load/getload.sh)

        sys_rows=""
        while IFS= read -r line; do
          key=$(echo "$line" | awk '{print $1}')
          value=$(echo "$line" | awk '{print $2}')
          sys_rows+="$key $value "
        done <<< "$sys_output"

        response=$(zenity --list \
          --title="System Metircs" \
          --text="Syste Metrics:" \
          --width=600 \
          --height=400 \
          --column="Duration" --column="Value" \
          $sys_rows)

        [ $? -eq 1 ] && break
      else
        zenity --error --text="The script get_sys_load/getload.sh was not found."
        break
      fi
      sleep 3
    done

  else
    break
  fi

  sleep 3
done
