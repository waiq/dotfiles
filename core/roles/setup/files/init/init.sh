#!/bin/bash

# shellcheck disable=SC1090
for i in "$(dirname "$0")"/init.d/*; do 
  source "$i";
done
