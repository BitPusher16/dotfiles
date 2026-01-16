#!/bin/bash

# Get the current pane's working directory
CURRENT_DIR=$(tmux display-message -p "#{pane_current_path}")

# Split the window vertically, set the directory, and start gdb in the new pane
tmux split-window -h -c "$CURRENT_DIR" "python -m pdb hello.py"
