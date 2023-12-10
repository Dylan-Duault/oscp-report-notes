#!/bin/bash

# Prompt for target IP address
read -p "Enter target IP address: " targetIp

# Create directory for saving scan results
mkdir -p "scans/$targetIp"

# Run initial Nmap scan to find open ports and save the output
nmap -p- -T4 "$targetIp" -oG open-ports.txt

# Extract open ports from the saved file
nmapPorts=$(grep -oP '\d+/open' open-ports.txt | cut -d '/' -f 1 | tr '\n' ',' | sed 's/,$//')

# Check if any ports were found
if [ -z "$nmapPorts" ]; then
    echo "No open ports found."
else
    # Run detailed Nmap scan on identified ports and save the output
    nmap -p"$nmapPorts" -sC -sV "$targetIp" > "scans/$targetIp/nmap.txt"
fi

echo "Scan complete. Results are saved in scans/$targetIp/nmap.txt"