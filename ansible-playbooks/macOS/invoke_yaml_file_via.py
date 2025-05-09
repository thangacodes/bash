import subprocess
import os
import time
import datetime
now = datetime.datetime.now()
print("Script executed at:", now.strftime("%Y-%m-%d %H:%M:%S"))
print("This is to invoke an Ansible playbook via Python3")
# Prompt user for playbook name
playbook_name = input("Enter the name of the Ansible playbook (e.g., localhost.yaml): ").strip()
print(f"User entered yaml file name is: {playbook_name}")

# Check if the file exists in the current directory
if os.path.isfile(playbook_name):
    try:
        result = subprocess.run(
            ["ansible-playbook", playbook_name],
            check=True,
            capture_output=True,
            text=True
        )
        print(f"\n{playbook_name} has executed successfully")
        time.sleep(4)
        user_input = input("Do you want to see the playbook execution result captured (say 'yes' or 'no'): ").strip().lower()
        print(f"User input is: {user_input}")
        if user_input == "yes":
            print("Displaying playbook execution output:")
            print(result.stdout)
        else:
            print("Playbook output display skipped.")
        print(result.stdout)
    except subprocess.CalledProcessError as e:
        print("\nError running playbook:")
        print(e.stderr)
else:
    print(f"\nError: The file '{playbook_name}' doesn't exist in the directory {os.getcwd()}.")
