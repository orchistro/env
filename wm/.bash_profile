# .bash_profile

# Get the aliases and functions
export KUSER_ID=$(kinit < /dev/null 2>&1 | head -1 | awk '{print $3}' | sed "s/@NAVER.COM://")
user_rc=".bashrc_$KUSER_ID"
if [ -f $user_rc ]; then
    . $user_rc
elif [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# User specific environment and startup programs

PATH=/usr/local/bin:$PATH:$HOME/bin

export PATH
export SVN_EDITOR=vim

