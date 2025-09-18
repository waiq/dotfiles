#!/bin/bash

init_d=~/.my/init/init.d
custom_d=~/.my/init/custom.d

if [ -n "$(ls -A $init_d)" ]; then
    # shellcheck disable=SC1090
    for i in $init_d/*; do
        source "$i"
    done
fi

if [ -n "$(ls -A $custom_d)" ]; then
    # shellcheck disable=SC1090
    for i in $custom_d/*; do
        source "$i"
    done
fi
