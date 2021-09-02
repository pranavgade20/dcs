#!/bin/bash

set -e

if [ $# = 0 ]; then
    echo "Usage: dcs COMMAND [PARAMETERS]"
    echo "Try 'dcs help' for more information."
fi

if [[ $1 = "help" ]]; then
    echo "Usage: dcs COMMAND [PARAMETERS]"
    echo ""
    echo "Commands:"
    echo "  init         initialize a repo in the current directory"
    echo "  commit       create a new commit"
    echo "  push <tag>   push this repo to a registry with <tag>"
    echo "  pull <tag>   pull a repo from a registry with <tag>"
fi

if [[ $1 = "init" ]]; then
    echo -e "FROM scratch \n"\
    "COPY . /" > "$(pwd)/Dockerfile.dcs"

    tag="$(openssl rand -hex 48)"
    docker build --file Dockerfile.dcs --tag $tag `pwd`

    echo -e "FROM $(docker images --digests | grep $tag | head -n 1 | awk '{print $4}') \n" \
    "COPY . /" > "$(pwd)/Dockerfile.dcs"
fi

if [[ $1 = "commit" ]]; then
    tag="$(openssl rand -hex 48)"
    docker build --file Dockerfile.dcs --tag $tag `pwd`

    echo -e "FROM $(docker images --digests | grep $tag | head -n 1 | awk '{print $4}') \n" \
    "COPY . /" > "$(pwd)/Dockerfile.dcs"
fi

if [[ $1 = "push" ]]; then
    if [ ! $# = 2 ]; then
        echo "Usage: dcs push <tag>"
    fi
    docker image tag $(head -n 1 "$(pwd)/Dockerfile.dcs" | awk '{print $2}') $2
    docker image push --all-tags $2
fi

if [[ $1 = "pull" ]]; then
    if [ ! $# = 2 ]; then
        echo "Usage: dcs pull <tag>"
    fi
    docker image pull --all-tags $2
    temp_dir=$(mktemp -d)
    docker save $2 | tar -C $temp_dir -xf -
    latest_tag=$(grep -o '"latest":"\w*"' "$2/repositories"  | grep -o ':"\w*' | grep -o '\w*')
    tar -C `pwd` -xf "$temp_dir/$latest_tag/layer.tar"
    rm -r "$temp_dir"
fi

