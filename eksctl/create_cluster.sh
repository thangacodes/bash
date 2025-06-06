#!/bin/bash
set -e
echo "Script runs at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "*********************************************"
echo " EKS cluster provision via eksctl tool       "
echo "*********************************************"

# Variables
manifest_file_name="cluster.yaml"
keyname="bastion"
aws_profile="vault"

# Reference link
echo "Please refer this eksctl documentation page always"
echo "*********************************************"
echo " https://eksctl.io/getting-started/"
echo "*********************************************"
sleep 2

create(){
  echo "Create EKS cluster"
  echo "Dry run command begins shortly..."
  echo ""
  AWS_PROFILE="${aws_profile}" eksctl create cluster -f "${manifest_file_name}" --dry-run
  read -p "Do you want to create the cluster now (say yes or no) : " INPUT
  echo "User entered input is: $INPUT"
  sleep 2
  if [[ "$INPUT" == "yes" || "$INPUT" == "y" ]]; then
    echo "You are good to provision EKS cluster on public subnets..."
    echo ""
    eksctl create cluster -f "${manifest_file_name}" --ssh-access --ssh-public-key "${keyname}" --profile "${aws_profile}"
  elif [[ "$INPUT" == "no" || "$INPUT" == "n" ]]; then
    echo "Your input is: ${INPUT} and it can be ignored.."
  else
    echo "You should enter 'yes' or 'no'. Please check the input."
  fi 
}

delete(){
  echo "Delete EKS cluster begins shortly.."
  read -p "Do you want to delete the cluster now (say yes or no) : " ACTION
  echo "User entered input as: ${ACTION}"
  sleep 2
  if [[ "$ACTION" == "yes" || "$ACTION" == "y" ]]; then
    echo "You are good to delete EKS cluster created on public subnets..."
    echo ""
    eksctl delete cluster -f "${manifest_file_name}" --ssh-public-key "${keyname}" --profile "${aws_profile}"
  elif [[ "$ACTION" == "no" || "$ACTION" == "n" ]]; then
    echo "Your input is: ${ACTION} and it can be ignored.."
  else
    echo "You should enter 'yes' or 'no'. Please check the input."
  fi 
}

read -p "Do you want to (c)reate or (d)elete the cluster? " action
if [[ "$action" == "c" || "$action" == "create" ]]; then
  create
elif [[ "$action" == "d" || "$action" == "delete" ]]; then
  delete
else
  echo "Invalid option selected. Exiting."
  exit 1
fi
