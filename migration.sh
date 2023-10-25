#!/bin/bash

# Prompt the user for the VPS ID
read -p "Enter the VPS ID: " vps_id

# Check if the VPS ID is provided
if [ -z "$vps_id" ]; then
    echo "VPS ID is required. Exiting."
    exit 1
fi

# Stop the VPS using vzctl
vzctl stop "$vps_id"

# Check the exit status of vzctl
if [ $? -eq 0 ]; then
    echo "VPS $vps_id has been stopped."
else
    echo "Failed to stop VPS $vps_id. Aborting."
    exit 1
fi

# Assuming ./ovztransfer.sh accepts the source and destination as arguments
./ovztransfer.sh 23.95.94.130 "$vps_id:$vps_id"

# Check the exit status of ./ovztransfer.sh
vzctl start "$vps_id"
