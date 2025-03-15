#!/bin/bash
echo "Script executed at: $(date '+%Y-%m-%d %H:%M:%S')"
echo ""
echo "*******************************"
echo "  Kubernetes in Docker (KIND)  "
echo "*******************************"
echo ""
echo "This script creates a KIND cluster along with worker nodes to test Kubernetes features"
echo "Script begins now..."
echo ""

# Check if kind and kubectl are installed
if ! command -v kind &> /dev/null || ! command -v kubectl &> /dev/null
then
    echo "Error: kind and kubectl are required but not installed."
    exit 1
fi

create_kind_cluster(){
    read -p "Enter the name of the cluster that you want to create: " CC_NAME
    echo "User entered the cluster name is: $CC_NAME"
    kind create cluster --name "$CC_NAME"
    if [ $? -eq 0 ]; then
        echo "Cluster $CC_NAME created successfully."
    else
        echo "Failed to create the cluster $CC_NAME."
        exit 1
    fi
    echo "Checking if the KIND cluster is created:"
    kubectl get nodes
}

delete_kind_cluster(){
    read -p "Enter the name of the cluster that you want to delete: " DC_NAME
    echo "User entered the cluster name is: $DC_NAME"
    kind get clusters | grep -q "$DC_NAME"
    if [ $? -eq 0 ]; then
        kind delete cluster --name "$DC_NAME"
        if [ $? -eq 0 ]; then
            echo "Cluster $DC_NAME deleted successfully."
        else
            echo "Failed to delete the cluster $DC_NAME."
            exit 1
        fi
    else
        echo "Cluster $DC_NAME does not exist."
        exit 1
    fi
    echo "Checking if the KIND cluster is deleted:"
    kubectl get nodes
}

echo "Choose the option based on your needs:"
echo "1. Create a new cluster"
echo "2. Delete an existing cluster"
echo "3. Exit"
read -p "Enter your choice (1/2/3): " choice

case $choice in
    1)
        create_kind_cluster
        ;;
    2)
        delete_kind_cluster
        ;;
    3)
        echo "Exiting script."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please select 1, 2, or 3."
        exit 1
        ;;
esac
