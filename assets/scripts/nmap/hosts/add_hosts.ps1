# PowerShell Script to Add Entries to hosts File

# Prompt for IP address and hostnames
$ip = Read-Host -Prompt "Enter the IP address"
$hostnames = Read-Host -Prompt "Enter the hostname(s)"

# Define the path to the hosts file
$hostsPath = "C:\Windows\System32\drivers\etc\hosts"

# Add entry to hosts file
Add-Content -Path $hostsPath -Value "$ip $hostnames"

Write-Host "Entry added successfully to hosts file."
