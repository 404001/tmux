#!/bin/bash

sudo apt update && sudo apt install -y tmux

echo "Configuring tmux for topbar"
cat <<EOT > ~/.tmux.conf
set -g mouse on
set -g prefix C-a
unbind C-b
bind C-a send-prefix
setw -g automatic-rename on
set -g status-interval 5
set -g status-justify left
set -g status-bg black
set -g status-fg white
set -g status-left-length 100
set -g status-right-length 100

# Topbar content
set -g status-position top
set -g status-left " User: #(whoami) "
set -g status-right " #[fg=cyan]IP: #(hostname -I | awk '{print $1}') #[fg=white]| #[fg=yellow]Time: %H:%M:%S "
EOT

source ~/.tmux.conf

echo "Starting tmux session with topbar"
tmux new-session -d -s topbar
tmux attach -t topbar
