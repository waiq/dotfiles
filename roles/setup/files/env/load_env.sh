#!/bin/bash

# shellcheck disable=SC1090
for env in "$(dirname "$0")"/env.d/*; do 
  source "$env";
done
