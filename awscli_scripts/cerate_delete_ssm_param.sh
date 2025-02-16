#!/bin/bash

# Variables:
REGION="ap-south-1"
PROFILE="vault_admin"
VALUE="parameter1-2"

display_time(){
    echo "Script execution time:" $(date '+ %d-%m-%Y %H:%M:%S')
    echo "Create String parameter and update the value using AWS CLI.."
}
check_exist_string_param(){
    echo "Checking if any existing String parameters available on $REGION..."
    aws ssm describe-parameters \
    --query "Parameters[?Type=='String'].Name" \
    --region $REGION \
    --profile $PROFILE
}
create_string_param(){
    read -p "Enter the String parameter name please:" PARAMETER_NAME
    echo "User would like to create a string parameter as:" $PARAMETER_NAME
    aws ssm put-parameter \
        --name $PARAMETER_NAME \
        --value $VALUE \
        --type "String" \
        --description "used to store private key content" \
        --overwrite --region $REGION --profile $PROFILE
}
get_created_string_param(){
    aws ssm get-parameter \
        --name $PARAMETER_NAME \
        --with-decryption --region $REGION --profile $PROFILE
}

delete_ssm_param(){
    read -p "Do you want to delete the SSM_Param ('say yes or no')? " USER_ACTION
    echo "User entered input as:" $USER_ACTION
    if [[ $USER_ACTION == "yes" || $USER_ACTION == "y" ]]; then
        echo "You are good to delete the string parameter:" $PARAMETER_NAME
        echo ""
        echo "Deleting begins shortly..."
        aws ssm delete-parameters \
        --names $PARAMETER_NAME --region $REGION --profile $PROFILE
    elif [[ $USER_ACTION == "no" || $USER_ACTION == "n" ]]; then
        echo "User entered the input as:" $USER_ACTION
    else
        echo "Please select the option as 'yes' or 'no':"
    fi
}
# Invoking defined functions
display_time
create_string_param
get_created_string_param
delete_ssm_param
