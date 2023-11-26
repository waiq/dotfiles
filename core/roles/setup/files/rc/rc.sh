#!/bin/bash

# shellcheck disable=SC1090
for rc in "$(dirname "$0")"/rc.d/*; do 
  source "$rc";
done
