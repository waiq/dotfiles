#!/bin/bash

set -e

ansible_version="2.14.2"

# ansible config files
install_yml="$(dirname "$0")/main.yml"
inventory="$(dirname "$0")/inventory"
requirements="$(dirname "$0")/requirements.yml"

export PATH=$PATH:~/.local/bin

if ! [ -x "$(command -v pipx)" ]; then
  echo "pipx not found"
  exit 1;
fi

if ! [ -x "$(command -v ansible)" ]; then
  pipx install --include-deps ansible
fi

if ! [ -x "$(command -v ansible-playbook)" ]; then
  echo "ansible-playbook not found"
  exit 1;
fi

if ! [ -x "$(command -v ansible-galaxy)" ]; then
  echo "ansible-galaxy not found"
  exit 1;
fi

# install community
ansible-galaxy install -r $requirements

if ! [ -f "$install_yml" ]; then
 echo "install.yml not found"
 exit 1
fi

if ! [ -f "$inventory" ]; then
  echo "inventory file not found"
  exit 1
fi

ansible_playbook_command="ansible-playbook -i $inventory $install_yml --ask-become-pass" 

# Function to display script usage
usage() {
 echo "Usage: $0 [OPTIONS]"
 echo "Options:"
 echo " -h, --help          Display this help message"
 echo " -v, --verbose       Enable verbose mode"
 echo " -n, --skip-git-pull Skip git pull"
}

# Function to handle options and arguments
handle_options() {
  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
        ;;
      -v | --verbose)
        ansible_playbook_command="$ansible_playbook_command -v"
        echo "Verbose mode enabled."
        ;;
      -n | --skip-git-pull*)
        ansible_playbook_command="$ansible_playbook_command --extra-vars \"{\"install\": { \"git_pull\": false }}"\"
        echo "Skip pull git repository"
        ;;
      *)
        echo "Invalid option: $1" >&2
        usage
        exit 1
        ;;
    esac
    shift
  done
}

# Main script execution
handle_options "$@"

eval "$ansible_playbook_command -t setup"
