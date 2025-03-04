#!/bin/bash
echo "Script to create a venv using python3"
echo ""
echo "Checking python installed/available version on mac book"
python3 --version
echo ""

# Create a virtual environment named "boto3"
python3 -m venv boto3

# Activate the virtual environment
source boto3/bin/activate

# Upgrade the latest pip module
pip install --upgrade pip
# Install boto3 inside the virtual environment
pip install boto3

# Create a Python script (s3_list.py) that lists S3 buckets
cat <<EOF > s3_list.py
import boto3

# Create a session using the 'vault_admin' profile
session = boto3.Session(profile_name="vault_admin")

# Create an S3 client using the session
s3 = session.client('s3')

# List all the S3 buckets in your AWS account
response = s3.list_buckets()

# Extract the list of bucket names
buckets = response['Buckets']

print("List of S3 Buckets:")
for bucket in buckets:
    print(bucket['Name'])
EOF

echo ""
echo "Executing python3 script to list S3 buckets..."
python3 s3_list.py

# Deactivate the Venv
deactivate
exit
