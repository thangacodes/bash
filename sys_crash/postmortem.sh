#!/bin/bash

# Ensure the user provides the start and end times
if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <start_time> <end_time>"
  exit 1
fi

# Get the timing parameters (start and end times)
start_time="$1"
end_time="$2"

# Kernel OOM / crash messages around the outage
echo "--- OOM / Kernel Messages ---"
sudo journalctl -k --since "$start_time" --until "$end_time" | grep -iE "oom|kill|hung|panic"

# System logs around the outage
echo "--- System Logs ---"
sudo journalctl --since "$start_time" --until "$end_time" | grep -iE "error|fail|oom|kill|panic"

# Processes consuming high CPU or memory currently (after reboot)
echo "--- Top Memory-consuming processes ---"
ps aux --sort=-%mem | head -20

echo "--- Top CPU-consuming processes ---"
ps aux --sort=-%cpu | head -20

# Check swap and memory usage
echo "--- Memory and Swap Usage ---"
free -h

# Check recent reboots / shutdowns
echo "--- Recent Reboots / Shutdowns ---"
last -x | head -10

# check for any coredumps or crash reports
echo "--- Core Dumps / Crash Reports ---"
ls -lh /var/crash/ 2>/dev/null

## how to run this script ?

## ./postmortem.sh "2025-12-05 00:45" "2025-12-06 01:00"
