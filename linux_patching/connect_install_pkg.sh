# Legacy-style patching of Linux servers via shell script from a bastion host, instead of using Ansible

#!/bin/bash

echo "Script runs at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "========================================================"
echo " Script to connect to remote machines and check BIND9   "
echo "========================================================"

# Variables
SSH_USER="ec2-user"
SSH_KEY="$HOME/.ssh/pem-file"
SERVERS_FILE="servers.txt"

# Loop through each server
while IFS= read -r IP; do
    echo "--------------------------------------------------------"
    echo "Connecting to server: $IP"
    echo "--------------------------------------------------------"
    ssh -o StrictHostKeyChecking=no -i "$SSH_KEY" "$SSH_USER@$IP" bash << 'EOF'
        echo "Cross checking the machine IP address and FQDN..."
        fqdn=$(hostname -f)
        ip=$(hostname -i)
        echo "Hostname Of Server: $fqdn"
        echo "IP Address Of Server: $ip"
        echo "Checking if bind9 packages are installed..."
        if dpkg -l | grep -qE "bind9"; then
            echo "bind9 package found."
            echo "Checking current BIND version:"
            version=$(sudo named -v)
            echo "Current bind9 version is: $version"
            required_version="BIND 9.16.50-Debian"
            if echo "$version" | grep -q "$required_version"; then
              echo "The required package version is installed and met our expectation on:"
            else
              echo "The required package version is NOT exist, hence installing it."
              sudo apt install --only-upgrade bind9 -y 
              echo "Cross checking bind9 version after upgrade.."
              sudo named -v
            fi
        else
          echo "bind9 package is not installed on this machine."
        fi
EOF
echo "Finished checking machine: $IP"
done < "$SERVERS_FILE"
echo "All servers checked and upgraded bind9 package successfully.."
exit 0

