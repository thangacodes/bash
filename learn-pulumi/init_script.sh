#!/bin/bash
# Update and install Apache

# Variables
LOG_FILE="/tmp/init_script.log"

# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

sudo yum update -y
sudo yum install -y httpd
sudo systemctl enable httpd
sudo systemctl start httpd

# Simple index page
echo "<h1>Hello from Pulumi EC2</h1>" | sudo tee /var/www/html/index.html
