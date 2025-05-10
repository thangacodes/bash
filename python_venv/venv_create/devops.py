import random
def cloud_skills():
    cloud = ["AWS", "Azure", "GCP", "OCI", "VMware"]
    return random.choice(cloud)
def cm_tools():
    tool_names=["git","githubAction","jenkins","ansible","terraform","vault"]
    return random.choice(tool_names)
def container_skills():
    cont_names = ["docker", "docker-compose", "ECS", "EKS", "Kubernetes"]
    return random.choice(cont_names)
def monitoring_skills():
    monit_names = ["datadog", "prometheus", "grafana", "dynatrace", "AppDynamics"]
    return random.choice(monit_names)
def scripting_skills():
    script_names = ["bash", "java-script", "python", "Shell"]
    return random.choice(script_names)
    
# Call the function and print the result
if __name__ == "__main__":
    print(f"You should have knowledge of at least one public cloud provider: {cloud_skills()}")
    print(f"You should be familiar with the following tools: {cm_tools()}")
    print(f"You should know at least one container orchestration technology: {container_skills()}")
    print(f"You should be proficient in at least two monitoring tools: {monitoring_skills()}")
    print(f"You should have experience with at least two scripting languages: {scripting_skills()}")
