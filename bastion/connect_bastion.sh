#!/bin/bash
set -euo pipefail
echo "Script runs at: " $(date '+%Y-%m-%d %H:%M:%S')
echo "User input based to connect Prod ('bangalore/chennai/hyderabad/mumbai/') remote hosts"
## Variables
echo "#---------------------------------------------------------------------------------#"
bl="bastion1.dev.try-devops.xyz"
ch="bastion2.dev.try-devops.xyz"
hy="bastion3.dev.try-devops.xyz"
mu="bastion4.dev.try-devops.xyz"
user="admin"
# Prompt for the user input
read -p "Which host would you like to connect now ('bl'/'ch'/'hy'/'mu'): " region
echo "Based on your input, I am trying to connect to the \"$region\" machine"
# Using case statement to handle different user inputs
case "$region" in
    bl|BL)
        echo "Connecting to Bangalore bastion machine..."
        ssh "$user@$bl"
        ;;
    ch|CH)
        echo "Connecting to Chennai bastion machine..."
        ssh "$user@$ch"
        ;;
    hy|HY)
        echo "Connecting to Hyderabad bastion machine..."
        ssh "$user@$hy"
        ;;
    mu|MU)
        echo "Connecting to Mumbai bastion machine..."
        ssh "$user@$mu"
        ;;
    *)
        echo "Invalid input. Please enter regions like 'bl' or 'ch' or 'hy' or 'mu'"
        ;;
esac
