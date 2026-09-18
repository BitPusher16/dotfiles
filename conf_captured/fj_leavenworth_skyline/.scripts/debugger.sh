#!/bin/bash

## save current pane id.
#current_pane=$(tmux display-message -p "#{pane_id}")
#
## check if a tmux pane with title "debugger" already exists
#existing_pane=$(tmux list-panes -F "#{pane_id} #{pane_title}" | grep " debugger$" | awk '{print $1}')
#
#if [ -n "$existing_pane" ]; then
#    #tmux select-pane -t "$existing_pane"
#    #tmux send-keys -t "$existing_pane" "./debug.sh" C-m
#    #tmux send-keys -t "$existing_pane" "./debug.sh" C-m
#    tmux send-keys -t "$existing_pane" "./debug.py" C-m
#else
#    #tmux split-window -h -c "#{pane_current_path}"
#
#    #tmux split-window -fl 6 -c "#{pane_current_path}"
#    #tmux select-pane -T "debugger"
#    #tmux send-keys "./debug.sh" C-m
#
#    # create new pane detached (-d) full (f) horizontal (h) and capture its ID immediately.
#    #new_pane=$(tmux split-window -fl 12 -d -c "#{pane_current_path}" -P -F "#{pane_id}") # debug pane along bottom.
#    #new_pane=$(tmux split-window -hfl 60 -d -c "#{pane_current_path}" -P -F "#{pane_id}") # debug pane along right.
#    new_pane=$(tmux split-window -hf -d -c "#{pane_current_path}" -P -F "#{pane_id}") # debug pane along bottom.
#
#    # set the title using the standard escape sequence (no select-pane needed).
#    # ] means operating system command. 2 is rename.
#    tmux send-keys -t "$new_pane" "printf '\033]2;debugger\033\\'" C-m
#
#    # set tmux pane title using a user option @title.
#    #tmux set-option -t "$new_pane" -p @title "debugger"
#    
#    #tmux select-pane -t "$new_pane" -T "debugger"
#    #tmux select-pane -t "$current_pane"
#
#    #tmux send-keys -t "$new_pane" "./debug.sh" C-m
#    tmux send-keys -t "$new_pane" "./debug.py" C-m
#fi

#!/bin/bash

src_pane=$(tmux display-message -p "#{pane_id}")
project=$(tmux display-message -p -t "$src_pane" "#{pane_current_path}")

if [ ! -f "$project/debug.py" ]; then
    tmux display-message "no debug.py in $project"
    exit 1
fi

existing_pane=$(tmux list-panes -F "#{pane_id} #{pane_title}" | awk '$NF == "debugger" { print $1; exit }')

if [ -n "$existing_pane" ]; then
    tmux send-keys -t "$existing_pane" "./debug.py" C-m
    exit 0
fi

#new_pane=$(tmux split-window -hf -d -c "$project" -P -F "#{pane_id}")
#tmux send-keys -t "$new_pane" "printf '\\033]2;debugger\\033\\\\'" C-m
#tmux send-keys -t "$new_pane" "./debug.py" C-m

new_pane=$(tmux split-window -hf -d -c "$project" -P -F "#{pane_id}")
tmux select-pane -t "$new_pane" -T "debugger"
tmux select-pane -t "$src_pane"
tmux send-keys -t "$new_pane" "./debug.py" C-m
