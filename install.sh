#!/bin/sh
set -e

ansible_version="2.14.2"

tags="$1"

if [ -z $tags ]; then
  tags="all"
fi

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt install ansible $anible_verison -y
fi

ansible-galaxy collection install community.general

ansible-playbook -i ./hosts ./dotfiles.yml --ask-become-pass --tags $tags
