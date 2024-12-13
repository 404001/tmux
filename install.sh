#!/bin/bash

sudo apt update && sudo apt install -y tmux polybar

echo "Creating tmux configuration"
cat <<EOT > ~/.tmux.conf
set -g mouse on
set -g prefix C-a
unbind C-b
bind C-a send-prefix
setw -g automatic-rename on
set-option -g status off
EOT

echo "Configuring polybar"
mkdir -p ~/.config/polybar
cat <<EOT > ~/.config/polybar/config.ini
[bar/example]
width = 100%
height = 30
background = #222222
foreground = #ffffff
modules-left = tmux
EOT

cat <<EOT > ~/.config/polybar/launch.sh
#!/bin/bash
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
polybar example &
EOT
chmod +x ~/.config/polybar/launch.sh

~/.config/polybar/launch.sh

echo "Starting tmux session"
tmux new-session -d -s main

tmux send-keys -t main "~/.config/polybar/launch.sh" C-m
tmux attach -t main
