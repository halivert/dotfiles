xrdb -merge ~/.Xresources

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

exec i3
