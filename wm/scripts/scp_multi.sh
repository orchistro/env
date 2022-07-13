#!/bin/bash

source get_server_list.func

usage_string="Usage: ${0} <src local file> <dst remote file/location> <sever list file>"

if [ $# != 3 ];
then
    echo ${usage_string}
    exit 1
fi

src_local_file=${1}
dst_remote_file=${2}
server_list_file=${3}

server_list=$(get_server_list ${server_list_file})

for host in ${server_list};
do
    echo ${host}
    scp ${src_local_file} irteam@${host}:${dst_remote_file}
done

