"""
Using AWS Python with Pulumi, you can provision cloud resources such as a Security Group and an EC2 instance. 
Upon creation, the required Security Group is automatically attached to the EC2 instance.
"""

import pulumi
from pulumi_aws import ec2

# Create EC2 Security Group:
sgp = ec2.SecurityGroup('webserver-sgp', description ="Security Group for Web Server",
                    tags = {
                        "Name": "WebServer-SecurityGroup",
                        "Env": "Development",
                        "Owner": "td@example.com",
                        "CreationDate": "2025-09-19"
                    })

allow_ssh = ec2.SecurityGroupRule("AllowSSH", type="ingress", from_port =22, to_port=22,protocol="tcp",
                                cidr_blocks=["0.0.0.0/0"], security_group_id=sgp.id)
allow_http = ec2.SecurityGroupRule("AllowHTTP", type="ingress", from_port =80, to_port=80,protocol="tcp",
                                cidr_blocks=["0.0.0.0/0"], security_group_id=sgp.id)
allow_all_outbound = ec2.SecurityGroupRule("AllowALLOUT", type="egress", from_port =0, to_port=0,protocol="-1",
                                cidr_blocks=["0.0.0.0/0"], security_group_id=sgp.id)

# Export the Security Group id
pulumi.export("security_group_id", sgp.id)

# Create EC2 instance:
ec2_instance = ec2.Instance('web-server',
                            ami="ami-01b6d88af12965bb6",
                            instance_type ="t2.micro",
                            key_name = "pulumi",
                            vpc_security_group_ids=[sgp.id],
                            tags ={
                                "Name": "WebServer-SGP",
                                "Env": "Development",
                                "Owner": "Thangadurai@example.com",
                                "CreationDate": "09/19/2025"
                            })

# Export the public_ip for EC2 instance
pulumi.export('public_ip', ec2_instance.public_ip)
