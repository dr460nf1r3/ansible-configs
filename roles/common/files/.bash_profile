# Nicos .bashrc
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Watch motd
sleep 3

# Autostart Tmux
if [ "$SSH_CLIENT" != "" ]; then
  exec tmux
fi

# Startx automatically on TTY1
if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
  . startx
  logout
fi
