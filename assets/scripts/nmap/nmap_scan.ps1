# PowerShell Nmap Scanning Script

# Prompt for target IP address
$targetIp = Read-Host -Prompt "Enter target IP address"

# Define the path for open-ports and scans directory
$openPortsFile = "open-ports.txt"
$scanDir = "scans\$targetIp"

# Remove existing open-ports.txt file if it exists
if (Test-Path $openPortsFile) { Remove-Item $openPortsFile }

# Remove existing directory for the target IP if it exists
if (Test-Path $scanDir) { Remove-Item $scanDir -Recurse }

# Create directory for saving scan results
New-Item -ItemType Directory -Force -Path $scanDir

# Run initial Nmap scan to find open ports and save the output
nmap -p- -T4 $targetIp -oG $openPortsFile

# Extract open ports from the saved file
$nmapPorts = (Select-String -Path $openPortsFile -Pattern "\d+/open" | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value.Split('/')[0] }) -join ","

# Check if any ports were found
if ([string]::IsNullOrWhiteSpace($nmapPorts)) {
    Write-Host "No open ports found."
} else {
    # Run detailed Nmap scan on identified ports and save the output
    nmap -p$nmapPorts -sC -sV $targetIp | Out-File "$scanDir\nmap.txt"
}

Write-Host "Scan complete. Results are saved in $scanDir\nmap.txt"
