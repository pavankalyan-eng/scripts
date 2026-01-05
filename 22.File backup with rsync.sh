#!/bin/bash

# ---------- CONFIGURATION ----------
SOURCE_DIR="/home/user/Documents"         # Folder to back up
DEST_DIR="/home/user/backup"              # Backup location
LOGFILE="/var/log/rsync-backup.log"       # Log file path

# rsync options:
# -a  archive mode (recursive, preserve permissions, timestamps, etc)
# -v  verbose
# -h  human-readable numbers
# --delete  delete files in backup that no longer exist in source (optional)
# --exclude  skip specific files/folders
RSYNC_OPTS="-avh --delete --exclude='.cache'"

# ---------- SCRIPT START ----------
echo "----------------------------------------" >> "$LOGFILE"
echo "Backup started: $(date)" >> "$LOGFILE"

# Make sure destination directory exists
mkdir -p "$DEST_DIR"

echo "Running rsync backup..."
rsync $RSYNC_OPTS "$SOURCE_DIR/" "$DEST_DIR/" >> "$LOGFILE" 2>&1

# Check exit status (0 = success)
if [ $? -eq 0 ]; then
    echo "Backup completed successfully!" | tee -a "$LOGFILE"
else
    echo "Backup FAILED!" | tee -a "$LOGFILE"
fi

echo "Backup finished: $(date)" >> "$LOGFILE"
echo "----------------------------------------" >> "$LOGFILE"
