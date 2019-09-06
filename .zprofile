if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
bg_type='dark' #start with bushtrees
base16-manager set brushtrees-dark
export TERM=xterm
