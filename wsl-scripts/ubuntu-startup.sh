#!/bin/bash
echo "Script runs at:" $(date '+%d-%m-%Y %H:%M:%S')
echo "Script to start or stop the WSL Ubuntu machine based on user input."

function start_machine() {
    echo "WSL Ubuntu machine is starting soon..."
    echo ""
    echo "Listing installed distributions on this Windows machine:"
    wsl --list --verbose
    echo "Sleeping for 3 seconds..."
    sleep 3
    echo "Starting default Ubuntu machine now..."
    wsl -d Ubuntu
}

function stop_machine() {
    echo "WSL Ubuntu machine is stopping soon..."
    echo ""
    echo "Listing installed distributions on this Windows machine:"
    wsl --list --verbose
    echo "Sleeping for 3 seconds..."
    sleep 3
    echo "Stopping default Ubuntu machine now..."
    wsl --shutdown
}

# User Input
echo "What do you want to do with the WSL Ubuntu machine? (start/stop)"
read -r action

case "$action" in
    start|START|Start)
        start_machine
        ;;
    stop|STOP|Stop)
        stop_machine
        ;;
    *)
        echo "Invalid option. Please type 'start' or 'stop'."
        ;;
esac
