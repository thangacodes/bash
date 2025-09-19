#!/bin/bash
set -euo pipefail
#==========================================================================#
# Variables                                                                #
#==========================================================================#
PROJECT_DIR="$HOME/my-first-pulumi-proj"
VENV_DIR="$PROJECT_DIR/venv"
PULUMI_PROJECT_DIR="$PROJECT_DIR/project"
LOG_FILE="/tmp/my-first-pulumi-proj.log"

# Default Pulumi secrets passphrase (can be overridden)
: "${PULUMI_CONFIG_PASSPHRASE:=pulumi12345}"

# Start logging
exec > >(tee -a "$LOG_FILE") 2>&1

echo "=================================================="
echo "Pulumi Setup Script"
echo "Script runs at: $(date '+%Y-%m-%d %H:%M:%S')"
echo "Script execution logs captured and it stored in a file and stored in: $LOG_FILE"
echo "=================================================="

#==========================================================================#
# Pulumi CLI Installation                                                  #
#==========================================================================#
echo ""
echo "Installing Pulumi CLI..."
if ! command -v pulumi >/dev/null 2>&1; then
    curl -fsSL https://get.pulumi.com -o /tmp/install-pulumi.sh
    chmod +x /tmp/install-pulumi.sh
    sh /tmp/install-pulumi.sh
else
    echo "Pulumi CLI is already installed."
fi

# Add Pulumi to PATH for this session
export PATH=$PATH:$HOME/.pulumi/bin
echo "Pulumi version: $(pulumi version)"

#==========================================================================#
# Python Setup                                                             #
#==========================================================================#
echo ""
echo "Setting up Python virtual environment..."
mkdir -p "$PROJECT_DIR"
cd "$PROJECT_DIR"

if [ ! -d "$VENV_DIR" ]; then
    python3 -m venv "$VENV_DIR"
fi

echo "Activating Python virtual environment..."
source "$VENV_DIR/bin/activate"

echo "Upgrading pip..."
python3 -m pip install --upgrade pip

#==========================================================================#
# requirements.txt                                                         #
#==========================================================================#
echo ""
echo "Creating requirements.txt..."
cat <<EOL > "$PROJECT_DIR/requirements.txt"
pulumi>=3.0.0,<4.0.0
pulumi-aws>=7.0.0,<8.0.0
EOL

echo "Installing Python dependencies..."
pip install -r "$PROJECT_DIR/requirements.txt"

#==========================================================================#
# Pulumi Backend Selection                                                 #
#==========================================================================#
echo ""
echo "Choose Pulumi backend for state storage:"
echo "1) Local (store state files on this machine)"
echo "2) Pulumi Service (requires PULUMI_ACCESS_TOKEN)"
read -p "Select Option 1 or 2: " BACKEND_CHOICE

if [[ "$BACKEND_CHOICE" == "1" ]]; then
    echo "Using local backend..."
    pulumi login --local
else
    echo "Using Pulumi Service backend..."
    if [[ -z "${PULUMI_ACCESS_TOKEN:-}" ]]; then
        echo "ERROR: PULUMI_ACCESS_TOKEN not set. Please set it before running this script."
        echo "Get one from: https://app.pulumi.com/account/tokens"
        exit 1
    fi
    pulumi login https://app.pulumi.com
fi

#==========================================================================#
# Pulumi Project Setup                                                     #
#==========================================================================#
echo ""
mkdir -p "$PULUMI_PROJECT_DIR"
cd "$PULUMI_PROJECT_DIR"

# Generate a unique project name using timestamp
BASE_PROJECT_NAME="my-first-pulumi-proj"
TIMESTAMP=$(date +%s)
PROJECT_NAME="${BASE_PROJECT_NAME}-${TIMESTAMP}"

# Set the secrets passphrase for this session
export PULUMI_CONFIG_PASSPHRASE
# If you wanted to setup it permanently,
# source ~/.bashrc

if [ -f Pulumi.yaml ]; then
    echo "Pulumi project already exists. Skipping 'pulumi new'."
else
    echo "Creating a new Pulumi project with name: $PROJECT_NAME"
    pulumi new aws-python \
        --name "$PROJECT_NAME" \
        --stack dev \
        --yes \
        --description "My first automated Pulumi project setup"
fi

echo "================================================"
echo "Pulumi project setup complete."
echo "Pulumi project files are located at: $PULUMI_PROJECT_DIR"
echo "Logs are captured at: $LOG_FILE"
echo ""
echo "================================================"
echo "Run these commands to deploy:"
echo "cd $PULUMI_PROJECT_DIR"
echo "source $VENV_DIR/bin/activate"
echo "pulumi up"
echo "================================================"

exit 0
