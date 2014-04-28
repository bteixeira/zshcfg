shop_chpass() {
	local pass
	local pass2
	read -s '?Enter your password:' pass
	echo
	if [[ $1 = '-c' ]]; then
		read -s '?Confirm your password:' pass2
		echo
		if [[ $pass != $pass2 ]]; then
			echo 'Passwords do not match, exiting'
			return 1
		fi
	fi
	local encr=$(mvn --encrypt-password $pass)
	# escape left brace
	encr=${encr:s/'\{'/'\\{'/}
	# escape right brace
	encr=${encr:s/'\}'/'\\}'/}
	# escape slash
	encr=${encr:s/\//\\\/}
	local file=~/.m2/settings.xml
	perl -i -pe "BEGIN{undef \$/;} s/(<server>.*?<id>maven.*?<password>).*?(<\/password>.*?<\/server>)/\$1$encr\$2/smg" $file && echo "File $file changed"
}

