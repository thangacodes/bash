"""
Multiple EC2 instances with the same configuration using Pulumi.
Supports by using loops in Python..
"""

import pulumi
from pulumi_aws import ec2

# =====================================================================
# 1. Create Security Group with Tags
# =====================================================================
sgp = ec2.SecurityGroup(
    "web-server-sgp",
    description="Security Group for Web Server",
    tags={
        "Name": "WebServer-SecurityGroup",
        "Env": "Development",
        "Owner": "td@example.com",
        "CreationDate": "2025-09-19"
    }
)

# =====================================================================
# 2. Add Security Group Rules
# =====================================================================
ec2.SecurityGroupRule("AllowSSH",
    type="ingress",
    from_port=22,
    to_port=22,
    protocol="tcp",
    cidr_blocks=["0.0.0.0/0"],
    security_group_id=sgp.id
)

ec2.SecurityGroupRule("AllowHTTP",
    type="ingress",
    from_port=80,
    to_port=80,
    protocol="tcp",
    cidr_blocks=["0.0.0.0/0"],
    security_group_id=sgp.id
)

ec2.SecurityGroupRule("AllowAllEgress",
    type="egress",
    from_port=0,
    to_port=0,
    protocol="-1",
    cidr_blocks=["0.0.0.0/0"],
    security_group_id=sgp.id
)

# =====================================================================
# 3. Create Multiple EC2 Instances
# =====================================================================
instance_count = 2  # Change count based on your requirements
instances = []

for i in range(instance_count):
    instance = ec2.Instance(
        f"WebServer-{i+1}",  # Unique logical name
        ami="ami-01b6d88af12965bb6",
        instance_type="t2.micro",
        key_name="pulumi",
        vpc_security_group_ids=[sgp.id],
        tags={
            "Name": f"WebServer-{i+1}",
            "Env": "Development",
            "Owner": "td@example.com",
            "CreationDate": "2025-09-19"
        }
    )
    instances.append(instance)

# =====================================================================
# 5. Outputs
# =====================================================================
pulumi.export("security_group_id", sgp.id)
pulumi.export("instance_public_ips", [instance.public_ip for instance in instances])
pulumi.export("instance_public_dns", [instance.public_dns for instance in instances])
