#!/bin/bash

# Check if the script is run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Prompt for IP address and hostnames
read -p "Enter the IP address: " ip
read -p "Enter the hostname(s): " hostnames

# Add entry to /etc/hosts
echo "$ip $hostnames" >> /etc/hosts

echo "Entry added successfully to /etc/hosts."