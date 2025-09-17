#!/bin/sh
echo "Script runs at: $(date '+%Y-%m-%d %H:%M:%S')"

## Variables
nodes="node02 node03"
port=9876
for node in $nodes; do
    echo "Checking $node on port $port..."
    nc -zv -w 3 $node $port
    if [ $? -eq 0 ]; then
        echo "Port $port is OPEN on $node"
    else
        echo "Port $port is CLOSED on $node"
    fi
    echo "-----------------------------"
done
