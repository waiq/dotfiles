#!/bin/bash

set -e

# Function to display script usage
usage() {
  echo "Usage: $(basename $0) [OPTIONS] openapi_file.json|yaml|yml|json"
  echo "Options:"
  echo " -h, --help      Display this help message"
  echo " -p, --port      Set dockerport, default 80:8080"
}


if ! [ -x "$(command -v docker)" ]; then
  echo "install docker"
  exit 1;
fi

docker_image="swaggerapi/swagger-ui"
docker_port="80"
docker_command="docker run"

input_file=""

# Function to handle options and arguments
handle_options() {

  if [ $# -eq 0 ]; then
	usage
	exit 1
  fi

  while [ $# -gt 0 ]; do
    case $1 in
      -h | --help)
        usage
        exit 0
		;;
	  -p | --port)
		docker_port=$1
		;;
	  *)
		if [ ! -f $(realpath $1) ]; then
		  echo "can't find file"
		  exit 1
		fi
		input_file=$(realpath $1)
		;;
    esac
    shift
  done
}

# Main script execution
handle_options "${@}"

eval "$docker_command -p $docker_port:8080 -e SWAGGER_JSON=/spec/$(basename $input_file) -v /$(dirname $input_file):/spec $docker_image"
