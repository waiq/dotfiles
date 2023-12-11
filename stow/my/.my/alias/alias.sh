#!/bin/bash

# shellcheck disable=SC1090
for alias in "$(dirname "$0")"/alias.d/*; do 
  source "$alias";
done
