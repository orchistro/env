unset LC_ALL
export LANG='ko_KR.UTF-8'
export LC_MESSAGES='C'
export LC_TIME='C'
export LC_CTYPE='ko_KR.UTF-8'

export LESSCHARSET=utf-8

# disabling auto-logout
export TMOUT=

umask 0002

#########################################################
# platform dependent settings
#########################################################

ENVDIR=${HOME}/env

export HOSTNAME=$(hostname)

# To disable alternate screen feature
export LESS="-rfX"
export MANPAGER="/usr/bin/less"

#########################################################
# Load host specific setting file
#########################################################
source ${ENVDIR}/_${HOSTNAME}
source ${ENVDIR}/functions

#########################################################
# PROMPT
#########################################################

tmpfile=${ENVDIR}/__hostname
echo ${HOSTNAME} > ${tmpfile}

promptColor='1;30'

while read line
do
    pattern=$(echo ${line} | awk '{print $1}')

    grep ${pattern} ${tmpfile} > /dev/null 2>&1

    if [ "$?" -eq "0" ];
    then
        promptColor=$(echo ${line} | awk '{print $2}')
        break
    fi
done < ${ENVDIR}/prompt_color_for_host

rm -f ${tmpfile}

export PS1="\[\033[${promptColor}m\]\u@${HOSTNAME}:\w\$ \[\033[0m\]"



if [ "${USE_PROMPT_COMMAND}" == 'yes' ]; # terminal title
then
    # export PROMPT_COMMAND='echo -ne "\033]0;${LOGNAME}@${HOSTNAME}:${PWD/$HOME/~} $(date +%c)\007"'
    export PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}\007"'
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

