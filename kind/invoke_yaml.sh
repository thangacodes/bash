#!/bin/bash
echo "Script executed at: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "*******************************"
echo "  Kubernetes IN Docker (KIND)  "
echo "*******************************"
echo ""
echo "This script creates a KIND cluster along with worker nodes to test Kubernetes features"
echo "Script begins now..."
echo ""
kind create cluster --config k8_setup.yaml
echo "checking the cluster and node creation part.."
kubectl get nodes 
sleep 5
kubectl get nodes
