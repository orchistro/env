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

function isdigit()
{
    [ $# -eq 1 ] || return 0

    case $1 in
        *[!0-9]*|"") return 1;;
        *) return 0;;
    esac
}

function print_host()
{
    local host_name=${1}
    local color=""
    local host_grp=${host_name/.nm/}	# Removing .nm
    host_grp=${host_grp/*-/}		# Leaving grp number only

    if isdigit "${host_grp}"
    then
        color="3${host_grp}"
    else
        color="36"
    fi

    echo -e "\e[${color}m${host_name}\e[m"
}

for host in ${server_list};
do
    print_host ${host}
    rcp irteam@${host}:${dst_remote_file} ${src_local_file}.${host}
done

