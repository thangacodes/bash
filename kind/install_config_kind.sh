#!/bin/bash
echo "Script execution time is:" $(date '+ %d-%m-%Y %H:%M:%S')
echo ""
echo "Installation of Kind in Mac and Linux OS.."
MACHINE_ARCHITECTURE=$(uname -m)
OS_TYPE=$(uname)
echo "Hardware architecture for your laptop or desktop is: " $MACHINE_ARCHITECTURE
echo "Your Laptop or Desktop Operating System is: $OS_TYPE"
sleep 2

# Check if you are using Mac OS
if [[ $OS_TYPE == "Darwin" ]]; then
    echo "You are using $OS_TYPE OS.."
    if [[ $MACHINE_ARCHITECTURE == "arm64" ]]; then 
        echo "You are using ARM64 architecture.."
        echo "Downloading kind for ARM64 architecture..."
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-darwin-arm64
        ls -l
        chmod +x ./kind
        mv kind /usr/local/bin/kind
        echo "Checking kind version.."
        kind --version
        
    elif [[ $MACHINE_ARCHITECTURE == "x86_64" ]]; then
        echo "You are using x86_64 architecture.."
        echo "Downloading kind for x86_64 architecture..."
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-darwin-amd64
        ls -l
        chmod +x ./kind
        mv kind /usr/local/bin/kind
        echo "Checking kind version.."
        kind --version
    else
        echo "Unsupported architecture for Mac OS"
        exit 1
    fi

# Check if you are using Linux OS
elif [[ $OS_TYPE == "Linux" ]]; then
    echo "You are using Linux OS.."
    if [[ $MACHINE_ARCHITECTURE == "x86_64" ]]; then
        echo "You are using x86_64 architecture.."
        echo "Downloading kind for Linux x86_64 architecture..."
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-amd64
        ls -l
        chmod +x ./kind
        mv kind /usr/local/bin/kind
        echo "Checking kind version.."
        kind --version
        
    elif [[ $MACHINE_ARCHITECTURE == "arm64" ]]; then
        echo "You are using ARM64 architecture.."
        echo "Downloading kind for Linux ARM64 architecture..."
        curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.27.0/kind-linux-arm64
        ls -l
        chmod +x ./kind
        mv kind /usr/local/bin/kind
        echo "Checking kind version.."
        kind --version
    else
        echo "Unsupported architecture for Linux OS"
        exit 1
    fi

else
    echo "Unsupported OS platform. This script only supported macOS and Linux."
    exit 1
fi

echo "Kubernetes in Docker (kind) Download and installation is completed successfully."
exit 0
