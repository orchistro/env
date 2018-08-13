me=$(/usr/bin/whoami)
if [ "${me:0:6}" == "irteam" ];	# on naver servers
then
	kuser_id=$(kinit < /dev/null 2>&1 | head -1 | awk '{print $3}' | sed "s/@NAVER.COM://")
	user_rc=".bashrc_${kuser_id}"
	if [ -f "${user_rc}" ];
	then
		source ${user_rc}
	fi
else	# otherwise irteam
	source ${HOME}/env/bashrc
fi

export PATH=/usr/local/bin:${PATH}:${HOME}/bin

