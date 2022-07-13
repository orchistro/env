#!/bin/bash
set -e
function run()
{
    echo "EXECUTING: $@"
    eval $@
}

run rcp .vim.tar.bz2 	irteam@$@:/home1/irteam/.vim.tar.bz2
run rcp .prompt_color_shawn irteam@$@:/home1/irteam/.prompt_color_shawn
run rcp .bashrc_shawn	irteam@$@:/home1/irteam/.bashrc_shawn
run rcp .vimrc_shawn	irteam@$@:/home1/irteam/.vimrc_shawn
run rcp .bash_profile	irteam@$@:/home1/irteam/.bash_profile

run rsh -l irteam		$@ "tar jxf /home1/irteam/.vim.tar.bz2"

# rlogin -l irteam $@ -f
