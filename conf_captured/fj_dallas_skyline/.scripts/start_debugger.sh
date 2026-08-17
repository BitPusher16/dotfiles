#!/bin/bash

# Get the current pane's working directory
CURRENT_DIR=$(tmux display-message -p "#{pane_current_path}")

#~/.scripts/generate_breakpoints.sh $CURRENT_DIR
~/.scripts/generate_breakpoints.py $CURRENT_DIR

# Split the window vertically, set the directory, and start gdb in the new pane
tmux split-window -h -c "$CURRENT_DIR" "python -m pdb hello.py"
