import os
import subprocess
import datetime
import time
def script_exec_time():
    print("")
    now = datetime.datetime.now()
    print("Script execution time is:", now.strftime("%Y-%m-%d %H:%M:%S"))
    time.sleep(3)
def execute_playbooks_in_cwd():
    # Get current working directory
    print("")
    cwd = os.getcwd()
    print(f"Checking for YAML files in the path: {cwd}")
    # List all files in the current working directory
    files = os.listdir(cwd)
    # Filter for YAML files
    yaml_files = [i for i in files if i.endswith(('.yaml', '.yml'))]
    if not yaml_files:
        print("No YAML files found.")
        return
    # Execute each YAML file as an Ansible playbook
    for yaml_file in yaml_files:
        print("")
        print(f"Executing playbook: {yaml_file}")
        try:
            subprocess.run(['ansible-playbook', yaml_file], check=True)
        except subprocess.CalledProcessError as e:
            print(f"Error running playbook {yaml_file}: {e}")
if __name__ == "__main__":
    script_exec_time()
    execute_playbooks_in_cwd()
