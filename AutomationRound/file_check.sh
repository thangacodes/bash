#!/bin/bash

file_path="/home/raj/INFO/data/csv/anvi.csv"

if [ -f "$file_path" ]; then
    echo "file is exist"
else
    echo "file is not exist"
fi
