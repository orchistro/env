#!/bin/bash
set -e
# rcp .vim.tar.bz2 	irteam@$@:/home1/irteam/.vim.tar.bz2
# rcp .prompt_color_shawn irteam@$@:/home1/irteam/.prompt_color_shawn
# rcp .bashrc_shawn	irteam@$@:/home1/irteam/.bashrc_shawn
# rcp .vimrc_shawn	irteam@$@:/home1/irteam/.vimrc_shawn

# rsh -l irteam		$@ "tar jxf /home1/irteam/.vim.tar.bz2"

rlogin -l irteam $@ -f
