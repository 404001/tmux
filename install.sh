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
set -g status-justify centre
set -g status-bg black
set -g status-fg white
set -g status-left-length 50
set -g status-right-length 150

# Topbar content
set -g status-left "#(whoami)"
set -g status-right "IP: #(hostname -I | awk '{print $2}') | Adapter: #(ip link show | grep -E '^[2]: ' | awk -F: '{print $2}' | xargs) | #[fg=cyan]%H:%M:%S #[fg=yellow]%d-%m-%Y"
EOT

source ~/.tmux.conf

echo "Starting tmux session with topbar"
tmux new-session -d -s topbar
tmux attach -t topbar
