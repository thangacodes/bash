"""
Using AWS Python with Pulumi, you can provision cloud resources such as an S3 bucket and EC2 instances. 
This script will create a new S3 bucket, appending a unique identifier (e.g., "my-bucket-fderews") to the bucket name, and launch an EC2 instance.
The EC2 instance will be associated with an existing security group and keypair.
"""

import pulumi
from pulumi_aws import s3, ec2

# Create an AWS resources like S3 Bucket, EC2 instance)
bucket = s3.Bucket('my-bucket')

# Export the name of the bucket
pulumi.export('bucket_name', bucket.id)
# Create EC2 instance:
ec2_instance = ec2.Instance('test-server',
                            ami="ami-01b6d88af12965bb6",
                            instance_type ="t2.micro",
                            key_name = "pulumi",
                            vpc_security_group_ids=["sg-0fb1052b659369bb8"],
                            tags ={
                                "Name": "Test-Server",
                                "Env": "Development",
                                "Owner": "Thangadurai@example.com"
                            })

# Export the public_ip for EC2 instance
pulumi.export('public_ip', ec2_instance.public_ip)
