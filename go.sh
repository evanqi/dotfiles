#!/bin/bash
shopt -s expand_aliases
source ~/.bashrc

cd ~/caviar/projects
docker-memcached
docker-redis
cd deliver

# Start new tmux session
tmux new-session -s work -d
tmux rename-window -t work vim

####################################
# ---------- FIRST WINDOW ----------
####################################

# Start vim on first window
tmux send-keys -t work 'sssh' C-m
tmux send-keys -t work 'vim' C-m

# Split first window
tmux split-window -h -t work
tmux send-keys -t work 'sssh' C-m

#####################################
# ---------- SECOND WINDOW ----------
#####################################

# Run deliver server on second window
tmux new-window -t work
tmux rename-window -t work server
tmux send-keys -t work 'sssh' C-m
tmux send-keys -t work 'bin/web' C-m

# Split first pane vertically and run console
tmux split-window -h -t work
tmux send-keys -t work 'sssh' C-m
tmux send-keys -t work 'rails c' C-m

# Split second vertical pane horizontally
tmux split-window -v -t work
tmux send-keys -t work 'sssh' C-m

# Split first vertical pane horizontally
# Run webpack
tmux select-pane -L
tmux split-window -v -t work
tmux send-keys -t work 'sssh' C-m
tmux send-keys -t work 'bin/yarn-webpack-server' C-m

####################################
# ---------- THIRD WINDOW ----------
####################################

tmux new-window -t work
tmux rename-window -t work misc
tmux send-keys -t work 'sssh' C-m

#Split third window
tmux split-window -h -t work
tmux send-keys -t work 'sssh' C-m

# Go back to first window
tmux select-window -t work:1
tmux select-pane -t 0
tmux attach -t work
