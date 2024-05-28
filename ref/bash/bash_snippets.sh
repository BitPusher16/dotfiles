# write file system contents to timestamped file.
find / 2>/dev/null | sort > file_system_snapshot_$(date +"%Y-%m-%d_%z_%H-%M-%S")

# run bash as a non-login shell, write all var assignments to text file.
# (use -xl flag to run as login shell.)
# https://unix.stackexchange.com/questions/813/how-to-determine-where-an-environment-variable-came-from
PS4='+$BASH_SOURCE> ' BASH_XTRACEFD=7 bash -x 7 > bash_env.txt

# clean up the file generated above.
cat bash_env.txt | cut -d " " -f1 | uniq > unique_env.txt
