unset LC_ALL
export LANG='ko_KR.UTF-8'
export LC_MESSAGES='C'
export LC_TIME='C'
export LC_CTYPE='ko_KR.UTF-8'

# disabling auto-logout
export TMOUT=

umask 0002

#########################################################
# platform dependent settings
#########################################################

ENVDIR=${HOME}/env

HOSTNAME=$(/bin/hostname | sed 's/-.*//g')

# To disable alternate screen feature
export LESS="-rfX"
export MANPAGER="/usr/bin/less"
export LESSCHARSET=utf-8

#########################################################
# Load host specific setting file
#########################################################
osname=$(uname)
if [[ "$osname" == "Darwin" ]]; then
    # macos
    LS_MULTIBYTE_OPTION='-v'
    LS_COLOR_OPTION='-G'
elif [[ "$osname" == "Linux" ]]; then
    # linux
    LS_MULTIBYTE_OPTION=
    LS_COLOR_OPTION='--color=auto'
else
    LS_MULTIBYTE_OPTION=
    LS_COLOR_OPTION=
fi

source ${ENVDIR}/functions

#########################################################
# PROMPT
#########################################################
prompt_color=$(get_prompt_color ${ENVDIR}/prompt_colors.conf)
export PS1="\[\033[${prompt_color}m\]\u@${HOSTNAME}:\w\$ \[\033[0m\]"
export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD##*/}\007"'

#########################################################
# LS_COLORS
#########################################################
export LS_COLORS=':di=00;34:ex=00;32:ln=00;36'
# ls of OSX uses LSCOLORS instead of LS_COLORS. Refer to the man page of osx ls
export LSCOLORS='exgxcxdxcxegedabagacad'

#########################################################
# Terminal settings
#########################################################
stty intr "^c" erase "^?" susp "^z" kill "^u"

#########################################################
# PATH
#########################################################
export CDPATH=.:${HOME}:${HOME}/work
export PATH=/usr/local/bin:${ENVDIR}/bin:${PATH}

#########################################################
# LD_LIBRARY_PATH
#########################################################
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib
export MANPATH=${MANPATH}:/usr/local/share/man

#########################################################
# grep options
# requires gnu grep version 2.6+
#########################################################
grep_option_str='-I --color'

grep_exclude_files='*~ .\* #* *.map tags TAGS *_heapdebug *.output'
for i in ${grep_exclude_files}
do
    grep_option_str="${grep_option_str} --exclude=${i}"
done

grep_exclude_dirs='test .\*'
for i in ${grep_exclude_dirs}
do
    grep_option_str="${grep_option_str} --exclude-dir=${i}"
done

ulimit -c unlimited

#########################################################
# ALIASES
#########################################################
alias l="ls -F ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias ll="ls -laF ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias ls="ls -F ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias less="less -rfX"
alias grep="grep ${grep_option_str}" # macos의 grep도 gnu compatible로 변경됨

function alert_ssh_alive_interval()
{
    echo "==============================================================================="
    echo "Need to reset ServerAliveInterval in /etc/ssh/ssh_config."
    echo "Running Following:"
    echo "-------------------------------------------------------------------------------"
    echo "grep 'ServerAliveInterval.*30' /etc/ssh/ssh_config 1> /dev/null || \\"
    echo "sudo /bin/bash -c 'echo -e \"\tServerAliveInterval 30\" >> /etc/ssh/ssh_config'"
    echo "==============================================================================="

    grep 'ServerAliveInterval.*30' /etc/ssh/ssh_config 1> /dev/null \
        || sudo /bin/bash -c 'echo -e "\tServerAliveInterval 30" >> /etc/ssh/ssh_config'
}

grep 'ServerAliveInterval.*30' /etc/ssh/ssh_config 1> /dev/null || alert_ssh_alive_interval

