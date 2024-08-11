# print size of current dir
du -hs .

# print dir contents recursively, sort by filesize
du -ah . | sort -rh | head -20

# write file system contents to timestamped file.
find / 2>/dev/null | sort > file_system_snapshot_$(date +"%Y-%m-%d_%z_%H-%M-%S")

# run bash as a non-login shell, write all var assignments to text file.
# (use -xl flag to run as login shell.)
# https://unix.stackexchange.com/questions/813/how-to-determine-where-an-environment-variable-came-from
# note: this command must run as an interactive shell, or session files won't be loaded.
# this means you will need to run exit afterwards.
PS4='+$BASH_SOURCE> ' BASH_XTRACEFD=7 bash -x 7>bash_env.txt
# PS4='+$BASH_SOURCE> ' BASH_XTRACEFD=7 bash -x 7>bash_env.txt -i <(echo "exit")

# this version exits immediately and does not print any cruft to the console:
PS4='+$BASH_SOURCE> ' BASH_XTRACEFD=7 bash -x 1>/dev/null 7>bash_env.txt -i <(echo "exit")

# clean up the file generated above.
cat bash_env.txt | cut -d " " -f1 | uniq > unique_env.txt


