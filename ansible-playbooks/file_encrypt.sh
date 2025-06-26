#!/bin/bash
echo "script runs at:" $(date '+%Y-%m-%d %H:%M:%S')
echo "Script to (encrypt/decrypt) a file that contains secrets using ansible vault method..."
file_name="file.txt"

is_encrypted() {
  head -n 1 "$file_name" | grep -q '^\$ANSIBLE_VAULT;'
}

encrypt() {
  if is_encrypted; then
    echo "File '$file_name' is already encrypted."
  else
    ansible-vault encrypt "$file_name"
    echo "Encryption is successful."
  fi
}

decrypt() {
  if is_encrypted; then
    ansible-vault decrypt "$file_name"
    echo "Decryption is successful."
  else
    echo "File '$file_name' is not encrypted."
  fi
}

user_feed() {
  # Check if the file exists first
  if [[ ! -f "$file_name" ]]; then
    echo "Error: File '$file_name' not found!"
    exit 1
  fi

  # Show encryption status
  if is_encrypted; then
    echo "File '$file_name' is currently: Encrypted"
  else
    echo "File '$file_name' is currently: Not Encrypted"
  fi

  # Prompt user for operation
  read -rp "What operation would you like to perform (encrypt/decrypt): " OPS
  if [[ "$OPS" == "encrypt" ]]; then
    echo "Invoking encryption..."
    encrypt
  elif [[ "$OPS" == "decrypt" ]]; then
    echo "Invoking decryption..."
    decrypt
  else
    echo "Invalid option. Use only 'encrypt' or 'decrypt'."
    exit 1
  fi
}

# Start the workflow
user_feed
