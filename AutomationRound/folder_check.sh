#!/bin/bash
dir_path="/home/raj/INFO/data"
if [ -d "$dir_path" ]; then
    echo "folder is exist"
else
    echo "folder is not there"
fi
