```bash

This repo contains EKS cluster creation using the eksctl CLI tool on AWS Cloud.

# First, install eksctl if it is not already installed, then verify its version on the Linux/Unix machine.
  $ eksctl version  
    0.209.0

# EKSCTL command:

1) dry-run
   eksctl create cluster -f cluster.yaml --dry-run
2) create cluster
   eksctl create cluster -f cluster.yaml --ssh-access --ssh-public-key bastion --profile vault
2) delete cluster
   eksctl delete cluster -f cluster.yaml --ssh-access --ssh-public-key bastion --profile vault
