# write file system contents to timestamped file.
find / 2>/dev/null | sort > file_system_snapshot_$(date +"%Y-%m-%d_%z_%H-%M-%S")
