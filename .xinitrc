xrdb -merge ~/.Xresources

picom -b

systemctl --user import-environment DISPLAY XAUTHORITY

$HOME/.fehbg &
/usr/bin/blueman-applet &
$HOME/.bin/set-last-outputs

# eval $(kwalletd5)
# eval $(gnome-keyring-daemon --start)
# export SSH_AUTH_SOCK

echo "Hola hehehe" > /tmp/saludo
export DESKTOP_SESSION='i3'
exec i3 > $HOME/.cache/i3out 2> $HOME/.cache/i3err
