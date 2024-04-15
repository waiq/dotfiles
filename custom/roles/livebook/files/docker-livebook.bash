#!/bin/bash

set -e

# Function to display script usage
usage() {
  echo "Usage: $(basename $0) [OPTIONS] WORKING_DIR"
  echo "Options:"
  echo " -h, --help      Display this help message"
  echo " -p, --port      Set dockerport, default 8080"
  echo " -i, --iframeport Set iframeport, default 8081"
  echo ""
  echo "the WORKING_DIR can be set by the environment variable"
  echo "LIVEBOOK_WORKING_DIR"
}


if ! [ -x "$(command -v docker)" ]; then
  echo "install docker"
  exit 1;
fi

docker_image="ghcr.io/livebook-dev/livebook"
docker_port="8080"
docker_iframe_port="8081"
docker_command="docker run"

working_dir="${LIVEBOOK_WORKING_DIR}"

# Function to handle options and arguments
handle_options() {

  if [ $# -ne 0 ] && [ ! -f $(realpath $1) ]; then
	working_dir=$(realpath $1)
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
	  -i | --iframeport)
		docker_iframe_port=$1
		;;
    esac
    shift
  done
}

# Main script execution
handle_options "${@}"

if [ -z "${LIVEBOOK_WORKING_DIR}" ]; then
  echo "no working_dir"
  usage
  exit 1;
fi

eval "$docker_command -p $docker_port:8080 -p $docker_iframe_port:8081 --pull always -u $(id -u):$(id -g) -v $(dirname $working_dir):/data $docker_image"
