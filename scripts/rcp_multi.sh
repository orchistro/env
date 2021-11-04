#!/bin/bash

source get_server_list.func

usage_string="Usage: ${0} <src local file> <dst remote file/location> <sever list file>"

if [ $# -lt 3 ];
then
    echo ${usage_string}
    exit 1
fi

src_local_file=${1}
dst_remote_file=${2}
server_list_files=${@:3:$#}

server_list=$(get_server_list ${server_list_files})

for host in ${server_list};
do
    print_host ${host}
    rcp ${src_local_file} irteam@${host}:${dst_remote_file}
done

