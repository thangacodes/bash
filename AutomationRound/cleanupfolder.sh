#!/usr/bin/env bash
set -euo pipefail

DATA_DIR="data"
ARCHIVE_FILE="2026-02-02.tar.gz"

echo "This script will remove the following:"
echo "  - $DATA_DIR/csv/"
echo "  - $DATA_DIR/json/"
echo "  - $DATA_DIR/$ARCHIVE_FILE"

# Check data directory exists
if [[ ! -d "$DATA_DIR" ]]; then
  echo "Directory '$DATA_DIR' does not exist."
  exit 1
fi

read -rp "Are you sure you want to continue? Type 'yes' to confirm: " CONFIRM

if [[ "$CONFIRM" != "yes" ]]; then
  echo "Operation cancelled."
  exit 0
fi

echo "Deleting files..."
rm -rf "$DATA_DIR/csv"
rm -rf "$DATA_DIR/json"
rm -f  "$DATA_DIR/$ARCHIVE_FILE"

echo "Cleanup completed."
echo
echo "Current structure:"
tree "$DATA_DIR"
