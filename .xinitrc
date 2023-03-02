xrdb -merge ~/.Xresources

picom -b

systemctl --user import-environment DISPLAY XAUTHORITY

/home/hali/.fehbg &
/usr/bin/blueman-applet &

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

export DESKTOP_SESSION='i3'
exec i3 > $HOME/.cache/i3out 2> $HOME/.cache/i3err
