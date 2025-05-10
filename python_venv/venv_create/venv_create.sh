#!/bin/bash
############################################
# Script Name: Python Virtual ENV creation #
# Author: admin@try-devops.xyz             #
# Creation Date: 10/05/2025                #
# Usage: Works on UNIX/LINUX Systems       #
############################################
execution_time(){
    current_date=$(date '+%Y:%m:%d %H:%M:%S')
    echo "Script is executed at: $current_date"
}
venv_creation(){
    echo "Creating virtual environment (VENV) in the current directory: $(pwd)"
    local venv_name="anvi"
    local script_name="devops.py"
    # Create virtual environment
    echo "Creating virtual environment '$venv_name'..."
    python3 -m venv "$venv_name" || { echo "Failed to create virtual environment"; exit 1; }
    # Activate virtual environment
    source "$venv_name/bin/activate" || { echo "Failed to activate virtual environment"; exit 1; }
    # Install basic Python libraries
    echo "Installing/upgrading pip and required libraries..."
    pip install --upgrade pip || { echo "Failed to upgrade pip"; exit 1; }
    pip install boto boto3 awscli || { echo "Failed to install required libraries"; exit 1; }
    # Run the Python script
    echo "Executing '$script_name'..."
    python3 "$script_name" || { echo "Failed to execute $script_name"; exit 1; }
    # Wait for 5 seconds
    sleep 5
    # Deactivate and delete virtual environment
    echo "Deactivating virtual environment '$venv_name' and removing the directory..."
    deactivate || { echo "Failed to deactivate virtual environment"; exit 1; }
    rm -rf "$venv_name" || { echo "Failed to remove virtual environment directory"; exit 1; }
}
# Execution order
execution_time
venv_creation
