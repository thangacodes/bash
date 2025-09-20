"""
Using AWS Python with Pulumi, provisioning cloud resources such as a Security Group and an EC2 instance. 
Upon creation, the required Security Group is automatically attached to the EC2 instance.
Also, here we're using user_data scripts like bootstrap
"""
import pulumi
from pulumi_aws import ec2
import pathlib

# =====================================================================
# 1. Read user_data from file
# =====================================================================
script_path = pathlib.Path(__file__).parent / "init_script.sh"
user_data_content = script_path.read_text()

# =====================================================================
# 2. Create Security Group
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

# Security Group Rules
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
# 3. Create Multiple EC2 Instances with User Data
# =====================================================================
instance_count = 2
instances = []

for i in range(instance_count):
    instance = ec2.Instance(
        f"web-server-{i+1}",
        ami="ami-01b6d88af12965bb6",
        instance_type="t2.micro",
        key_name="pulumi",
        vpc_security_group_ids=[sgp.id],
        user_data=user_data_content,
        tags={
            "Name": f"WebServer-{i+1}",
            "Env": "Development",
            "Owner": "td@example.com",
            "CreationDate": "2025-09-19"
        }
    )
    instances.append(instance)

# =====================================================================
# 4. Outputs
# =====================================================================
pulumi.export("security_group_id", sgp.id)
pulumi.export("instance_public_ips", [instance.public_ip for instance in instances])
pulumi.export("instance_public_dns", [instance.public_dns for instance in instances])
pulumi.export(
    "webipendpoint", 
    [pulumi.Output.concat("http://", instance.public_ip) for instance in instances])
pulumi.export(
    "webhttpendpoint",
    [pulumi.Output.concat("http://", instance.public_dns) for instance in instances])
