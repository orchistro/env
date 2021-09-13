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

export HOSTNAME=$(/bin/hostname)

# To disable alternate screen feature
export LESS="-rfX"
export MANPAGER="/usr/bin/less"
export LESSCHARSET=utf-8

#########################################################
# Load host specific setting file
#########################################################
source ${ENVDIR}/hostconf/${HOSTNAME}.conf
source ${ENVDIR}/functions

#########################################################
# PROMPT
#########################################################
prompt_color=$(get_prompt_color ${ENVDIR}/hostconf/prompt_colors.conf)
export PS1="\[\033[${prompt_color}m\]\u@${HOSTNAME}:\w\$ \[\033[0m\]"

if [ "${USE_PROMPT_COMMAND}" == 'yes' ]; # terminal title
then
    export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD##*/}\007"'
fi

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
# X window display setting
# Since I started to use -X or -Y option of ssh, 
# no need to set DISPLAY
#########################################################
# if [ "${USE_LOCAL_X_SERVER}" == 'yes' ];
# then
#     export DISPLAY=:1.0
#     export DISPLAY=:0
# else
#     export DISPLAY=192.168.11.35:0
# fi

#########################################################
# PATH
#########################################################
export CDPATH=.:${HOME}:${HOME}/work

PATH=/usr/local/bin:${PATH}
PATH=${ENVDIR}/bin:${PATH}
PATH=${PATH}:/bin:/sbin:/usr/sbin:/usr/bin
PATH=${PATH}:/usr/X11R6/bin
export PATH

#########################################################
# LD_LIBRARY_PATH
#########################################################
export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/lib

# solaris handles 64 lib and 32 lib separately
export LD_LIBRARY_PATH_64=${LD_LIBRARY_PATH}

# aix uses LIBPATH instead of LD_LIBRARY_PATH
export LIBPATH=${LD_LIBRARY_PATH}

export MANPATH=${MANPATH}:/usr/local/share/man
#########################################################
# grep options
# requires gnu grep version 2.6+
#########################################################
grep_version_str=$(grep --version|awk '/GNU grep/ {print $NF}')
grep_version_maj=$(echo ${grep_version_str} | awk -F'.' '{print $1}')
grep_version_min=$(echo ${grep_version_str} | awk -F'.' '{print $2}')

if [ "${grep_version_str}" == "" ];
then
    GREP_OPTIONS=""
else
    grep_exclude_dirs='test .\*'
    grep_exclude_files='*~ .\* #* *.map tags TAGS *_heapdebug *.output'
    grep_option_str='-I --color'
    
    for i in ${grep_exclude_files}
    do
        grep_option_str="${grep_option_str} --exclude=${i}"
    done
    
    # for only GNU grep 2.6+, set exclude dir
    if [ ${grep_version_maj} -ge 2 ];
    then
        if [ $grep_version_min -ge 6 ];
        then
            for i in ${grep_exclude_dirs}
            do
                grep_option_str="${grep_option_str} --exclude-dir=${i}"
            done
        fi
    fi
    
    export GREP_OPTIONS=${grep_option_str}
fi

ulimit -c unlimited

#########################################################
# ALIASES
#########################################################

export EXUBERANT_CTAGS=/usr/local/bin/ctags-ex

alias l="ls -F ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias ll="ls -laF ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias ls="ls -F ${LS_COLOR_OPTION} ${LS_MULTIBYTE_OPTION}"
alias less="less -rfX"
alias svnlog='LC_ALL=ko_KR.UTF-8 svn log'
alias ctags="${EXUBERANT_CTAGS}"
alias UTF8='iconv -f euc-kr -t utf-8'
alias EUCKR='iconv -f utf-8 -t euc-kr'

if [ ! -z ${OS_NAME} ];
then
    if [ ${OS_NAME} == "osx" ];
    then
        alias tkdiff="/Applications/TkDiff.app/Contents/MacOS/tkdiff"
    fi
fi

function alert_ssh_alive_interval()
{
    echo "==============================================================================="
    echo "Need to reset ServerAliveInterval in /etc/ssh/ssh_config."
    echo "Run Following:"
    echo "-------------------------------------------------------------------------------"
    echo "grep 'ServerAliveInterval.*30' /etc/ssh/ssh_config 1> /dev/null || \\"
    echo "sudo /bin/bash -c 'echo -e \"\tServerAliveInterval 30\" >> /etc/ssh/ssh_config'"
    echo "==============================================================================="
}

grep 'ServerAliveInterval.*30' /etc/ssh/ssh_config 1> /dev/null && alert_ssh_alive_interval

