# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

export KUSER_ID=$(kinit < /dev/null 2>&1 | head -1 | awk '{print $3}' | sed "s/@NAVER.COM://")
user_rc=".bashrc_$KUSER_ID"
if [ -f $user_rc ]; then
    . $user_rc
elif [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

unset LC_ALL
export LANG='ko_KR.UTF-8'
export LC_MESSAGES='C'
export LC_TIME='C'
export LC_CTYPE='ko_KR.UTF-8'

unalias ls
alias l='ls -l --color=auto'
alias ll='ls -al --color=auto'
alias top='top -d 1'
alias rlogin='/usr/local/bin/rlogin -x'
alias kinit='/usr/local/bin/kinit -f'

export PATH=${PATH}:.

# User specific aliases and functions
