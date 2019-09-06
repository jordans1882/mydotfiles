xrdb ~/.Xresources

# Disable access control
xhost +SI:localuser:$USER

# Make Java applications aware this is a non-reparenting window manager.
export _JAVA_AWT_WM_NONREPARENTING=1

# Themes, etc
gnome-settings-daemon &

# Fallback cursor
xsetroot -cursor_name left_ptr

# Keyboard repeat rate
xset r rate 200 60

# Start Emacs
# exec dbus-launch --exit-with-session emacs

# Modify keys
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
xcape -e 'Control_L=Escape'

nm-applet &

feh --bg-scale /home/jordan/wallpaper/golden-gate-bridge.jpg &

xcompmgr &
# compton &

exec awesome
#exec stumpwm
#exec /home/jordan/.cabal/bin/xmonad
#exec /home/jordan/.xmonad/xmonad
#xmobar &
#exec xmonad
