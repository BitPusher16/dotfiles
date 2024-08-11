#!/usr/bin/bash
# run by setting chmod+x or do bash loop_256_colors.sh
for i in {0..255} ; do
  #printf "\x1b[38;5;%smcolor%s \x1b[38;5;%smcolor%s\n" "${i}" "${i}" "${i}" "${i}"
  printf "\x1b[38;5;%smcolor%s\t" "${i}" "${i}"
done
