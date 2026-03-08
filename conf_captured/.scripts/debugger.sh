

#!/bin/bash

# check if a tmux pane with title "debugger" already exists
existing_pane=$(tmux list-panes -F "#{pane_id} #{pane_title}" | grep " debugger$" | awk '{print $1}')

if [ -n "$existing_pane" ]; then
    tmux select-pane -t "$existing_pane"
    tmux send-keys -t "$existing_pane" "./debug.sh" C-m
else
    tmux split-window -v
    tmux select-pane -T "debugger"
    tmux send-keys "./debug.sh" C-m
fi
