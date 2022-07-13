#!/bin/bash

source get_server_list.func

usage_string="Usage: ${0} <\"command\"> <sever list file>"

if [ $# != 2 ];
then
    echo ${usage_string}
    exit 1
fi

# echo "1 = ${1}"
command=${1}
# echo "command = $command"
server_list_file=${2}

server_list=$(get_server_list ${server_list_file})

for host in ${server_list};
do
    echo ${host}
    ssh -l irteam ${host} "${command}"
done

