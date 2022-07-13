#!/bin/bash
set -e
hostlistfile=$1

source scripts/get_server_list.func

command=${1}
server_list_files=${@:1:$#}
server_list=$(get_server_list ${server_list_files})

for h in ${server_list};do
    echo "================================"
    print_host $h
    echo "================================"
    ./install_env.sh $h
done
