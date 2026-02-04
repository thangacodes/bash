#!/bin/bash

# variables:
LOG_DIR="/var/log/nginx"

echo "Log cleanup script..."
echo "Removing .gz log files older than 30 days from $LOG_DIR .."

### To know things
# grep -q ==> meaning below
# Result: true (exit status 0)

# Check if there are any .gz files older than 30 days
if find "$LOG_DIR" -type f -name "*.gz" -mtime +30 | grep -q .; then
  echo "Files found. Good to delete .gz logs..."
  echo "Want to see what will be deleted first.."

  # Show files that will be deleted
  find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -print

  echo "Deleting .gz files older than 30 days.."
  find "$LOG_DIR" -type f -name "*.gz" -mtime +30 -delete

  echo "Deleted older than 30 days .gz log files."
else
  echo "No .gz files found."
fi
exit 0
