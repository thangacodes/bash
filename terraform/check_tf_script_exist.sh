#!/bin/bash
echo "Script to check terraform files in the current directory"

find_date() {
    echo "Today's date is: $(date)"
}

find_tf_script_exists() {
    echo "Checking the current working directory for any Terraform scripts: $(pwd)"
    echo -n "Do you want to check for .tf files? (yes/no || YES/NO): "
    read USER_INPUT

    if [ "$USER_INPUT" = "yes" ] || [ "$USER_INPUT" = "YES" ]; then
        if find . -maxdepth 1 -name "*.tf" | grep -q .; then
            echo "Terraform files exist in $(pwd)"
        else
            echo "No Terraform files exist in $(pwd)"
        fi
    else
        echo "Skipping Terraform file check."
    fi
}

echo -n "Do you want to check today's date? (yes/no || YES/NO): "
read USER_INPUT

if [ "$USER_INPUT" = "yes" ] || [ "$USER_INPUT" = "YES" ]; then
   echo "User entered: $USER_INPUT"
   echo "Checking date first, then Terraform script files..."
   find_date
   find_tf_script_exists
else
  echo "You entered: $USER_INPUT. Skipping all checks."
fi
