#!/bin/bash

source get_server_list.func

usage_string="Usage: ${0} <\"command\"> <sever list file>"

if [ $# -lt 2 ];
then
    echo ${usage_string}
    exit 1
fi

# echo "1 = ${1}"
command=${1}
# echo "command = $command"
# server_list_file=${2}
server_list_files=${@:2:$#}

server_list=$(get_server_list ${server_list_files})

for host in ${server_list};
do
    print_host ${host}
    rsh -l irteam ${host} -f "${command}"
done

