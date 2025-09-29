#!/bin/bash

# export GOPATH="/home/waiq/.my/local/go_dependencies"
# export PATH="/home/waiq/.my/local/go_dependencies/bin:/home/waiq/.my/local/go/bin":$PATH

export GOROOT=$(go1.24.0 env GOROOT)
export PATH=${GOROOT}/bin:${PATH}
