#!/bin/bash

# This script recursively searches the current directory for lines ending with "#bk"
# and generates a .pdbrc file with breakpoint commands for pdb.

#output=".pdbrc"


if [ $# -ne 1 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

dir="${1%/}"  # Remove trailing slash if present

output="$dir/.pdbrc"
#echo $output

# Clear or create the output file
> "$output"

# Use process substitution to handle grep output
while read -r grep_line; do
    # Extract filename (up to first :)
    file="${grep_line%%:*}"
    # Remove leading ./ if present
    file="${file#./}"
    
    # Extract the rest after first :
    rest="${grep_line#*:}"
    # Extract line number (up to next :)
    line_num="${rest%%:*}"
    
    # Append to .pdbrc
    echo "b ${file}:${line_num}" >> "$output"
done < <(grep -rn "#bk$" $dir)
