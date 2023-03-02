xrdb -merge ~/.Xresources

picom -b

systemctl --user import-environment DISPLAY XAUTHORITY

$HOME/.fehbg &
/usr/bin/blueman-applet &
$HOME/.bin/set-last-outputs

eval $(gnome-keyring-daemon --start)
export SSH_AUTH_SOCK

export DESKTOP_SESSION='i3'
exec i3 > $HOME/.cache/i3out 2> $HOME/.cache/i3err
