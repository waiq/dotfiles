#!/bin/bash

set -e

# Function to display script usage
usage() {
  echo "Usage: $(basename $0) [OPTIONS]"
  echo "Options:"
  echo " -h, --help        Display this help message"
  echo " -l, --list        list all images"
  echo " -r, --remove      Remove all images"
}

if ! [ -x "$(command -v docker)" ]; then
  echo "docker not intstalled"
  exit 1;
fi

docker_command='docker images -a'

# Function to handle options and arguments
handle_options() {

  if [ $# -eq 0 ]; then
	return
  fi

  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
		;;
	  -r | --remove)
		docker_command='docker rmi -f $(docker images -aq)'
		;;
	  *)
		usage
		;;
    esac
    shift
  done
}

# Main script execution
handle_options "${@}"

eval "$docker_command"
