xrdb -merge ~/.Xresources

picom -b

/home/hali/.fehbg &
/usr/bin/blueman-applet &
/usr/lib/kdeconnectd &

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

setxkbmap -option compose:ralt

export DESKTOP_SESSION='i3'
exec i3 > $HOME/.cache/i3out 2> $HOME/.cache/i3err
