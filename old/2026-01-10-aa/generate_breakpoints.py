#!/usr/bin/python

import os
import sys

def main():
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <directory>")
        sys.exit(1)

    # get absolute path and remove trailing separator if present.
    dir_path = os.path.abspath(sys.argv[1].rstrip(os.sep))  
    output = os.path.join(dir_path, '.pdbrc')

    # clear or create the output file.
    with open(output, 'w') as f:
        pass

    # walk dir recursively.
    for root, _, files in os.walk(dir_path):
        for filename in files:
            full_path = os.path.join(root, filename)

            with open(full_path, 'r') as f:
                for line_num, line in enumerate(f, start=1):
                    if line.rstrip().endswith('#bk'):
                        with open(output, 'a') as out_f:
                            out_f.write(f"b {full_path}:{line_num}\n")

if __name__ == "__main__":
    main()
