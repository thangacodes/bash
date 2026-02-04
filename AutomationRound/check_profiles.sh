#!/bin/bash

# banner
echo "Script to check two aws profiles configured for my student account.."

AWS_DIR="/root/.aws"
CRED_FILE="$AWS_DIR/credentials"

echo "Checking AWS credentials in /root/.aws ..."

# Check if .aws directory exists
if [[ ! -d "$AWS_DIR" ]]; then
  echo "ERROR: /root/.aws directory does not exist."
  exit 1
fi

# Check if credentials file exists
if [[ ! -f "$CRED_FILE" ]]; then
  echo "ERROR: credentials file not found in /root/.aws"
  exit 1
fi

# Check both profiles exist
if grep -q "^\[dev\]" "$CRED_FILE" && grep -q "^\[test\]" "$CRED_FILE"; then
  echo "Both profiles found in credentials file."
else
  echo "ERROR: Either [dev] or [test] is missing."
  exit 1
fi

# Testing dev profile
echo "Testing dev profile..."
aws sts get-caller-identity --profile dev --output text >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  echo "dev profile configured and works"
else
  echo "dev profile FAILED..."
fi

# Test test profile
echo "Testing test profile..."
aws sts get-caller-identity --profile test --output text >/dev/null 2>&1
if [[ $? -eq 0 ]]; then
  echo "test profile configured"
else
  echo "test profile FAILED..."
fi
exit 0
