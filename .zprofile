if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
	$HOME/.bin/i3-mkconfig
	exec startx
fi
