#!/bin/bash
echo "Script executed at:" $(date '+ %d-%m-%Y %H:%S:%M')

## Variables section
playbook_name="localhost.yaml"

read -p "Enter your input please (It should be 'yes or no') :" USER_INPUT
echo "User entered the input as:" $USER_INPUT

if [[ $USER_INPUT == "YES" || $USER_INPUT == "yes" ]]; then
   echo "You are good to invoke ansible playbook exist on the current working dir: $(pwd)"
   ansible-playbook "$playbook_name"
elif
   [[ $USER_INPUT == "NO" || $USER_INPUT == "no" ]]; then
   echo "Your input is: $USER_INPUT, hence further action can be ignored.."
else
   echo "Your answer is different. It should be ('YES/NO || yes/no')"
fi
