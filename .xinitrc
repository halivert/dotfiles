xrdb -merge ~/.Xresources

picom -b

/home/hali/.fehbg &
/usr/bin/blueman-applet &

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

exec i3
