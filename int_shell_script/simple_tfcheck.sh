#!/bin/sh
echo "Script to check terraform files in a current directory"
find_date() {
    echo "today's date is:" $(date)
}
find_tf_script_exists() {
    echo "Checking the current working directory for any Terraform scripts: $(pwd)"
    echo -n "Do you want to check for .tf files ? : "
    read USER_INPUT
    if [ "$USER_INPUT" = "yes" ] || [ "$USER_INPUT" = "YES" ]; then
        if ls *.tf >/dev/null 2>&1; then
            echo "Terraform files exist in $(pwd)"
        else
            echo "No Terraform files exist in $(pwd)"
        fi
    else
        echo "Skipping check."
    fi
}
echo -n "Do you want to check today's date ? :  "
read USER_INPUT
if [ "$USER_INPUT" = "yes" ] || [ "$USER_INPUT" = "YES" ]; then
   echo "User entered input as: $USER_INPUT"
   echo "checking first and date and then terraform script files.."
   find_date
   find_tf_script_exists
fi
exit 0
