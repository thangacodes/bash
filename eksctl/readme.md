```bash

# EKSCTL command:

1) dry-run
   eksctl create cluster -f cluster.yaml --dry-run
2) create cluster
   eksctl create cluster -f cluster.yaml --ssh-access --ssh-public-key bastion --profile vault
2) delete cluster
   eksctl delete cluster -f cluster.yaml --ssh-access --ssh-public-key bastion --profile vault
