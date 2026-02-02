#!/bin/bash
# --- 1. Handle Input Parameter ---
# Use the first argument if provided, otherwise default path
INPUT_DIR="${1:-/home/raj/INFO/data/input}"

# --- 2. Define Paths ---
CSV_DIR="/home/raj/INFO/data/csv"
JSON_DIR="/home/raj/INFO/data/json"
LOG_ARCHIVE="/home/raj/INFO/data/$(date +%Y-%m-%d).tar.gz"
SUMMARY_FILE="/home/raj/INFO/data/summary.txt"

# --- 3. Ensure Destination Directories Exist ---

# CSV directory check
if [ -d "$CSV_DIR" ]; then
    echo "Folder $CSV_DIR already exists. No need to create it."
else
    echo "Folder $CSV_DIR does not exist. Hence making it available..."
    echo ""
    echo "creating folder on the path $(pwd).."
    mkdir -p "$CSV_DIR"
    sleep 2
    tree data
fi

# JSON directory check
if [ -d "$JSON_DIR" ]; then
    echo "Folder $JSON_DIR already exists. No need to create it."
else
    echo "Folder $JSON_DIR does not exist. Hence making it available..."
    echo ""
    echo "creating folder on the path $(pwd).."
    mkdir -p "$JSON_DIR"
    sleep 2
    tree data
fi

# --- 4. Gather Statistics ---
# Count files BEFORE moving/copying
csv_count=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.csv" | wc -l)
json_count=$(find "$INPUT_DIR" -maxdepth 1 -type f -name "*.json" | wc -l)

# Get total size of .log files (safe if none exist)
log_size=$(du -ch "$INPUT_DIR"/*.log 2>/dev/null | tail -n 1 | cut -f1)
log_size=${log_size:-0}

# --- 5. File Operations ---

# Copy CSV files
find "$INPUT_DIR" -maxdepth 1 -type f -name "*.csv" -exec cp {} "$CSV_DIR/" \;

# Copy JSON files
find "$INPUT_DIR" -maxdepth 1 -type f -name "*.json" -exec cp {} "$JSON_DIR/" \;

# Compress CSV, JSON, and LOG files into one archive
find "$INPUT_DIR" -maxdepth 1 \( -name "*.csv" -o -name "*.json" -o -name "*.log" \) \
    | tar -czf "$LOG_ARCHIVE" -T - 2>/dev/null

# --- 6. Generate Summary Report ---
{
    echo "Summary Report - $(date)"
    echo "------------------------------------------"
    echo "Number of .csv files found: $csv_count"
    echo "Number of .json files found: $json_count"
    echo "Total size of .log files before compression: $log_size"
} > "$SUMMARY_FILE"

echo "Process complete. Summary saved to $SUMMARY_FILE"

# --- 7. Display Results ---
echo "Viewing summary file:"
cat "$SUMMARY_FILE"

echo
echo "------------------------------------------"
echo "Contents of Archive: $LOG_ARCHIVE"
tar -tf "$LOG_ARCHIVE"
echo "Total files archived: $(tar -tf "$LOG_ARCHIVE" | wc -l)"
