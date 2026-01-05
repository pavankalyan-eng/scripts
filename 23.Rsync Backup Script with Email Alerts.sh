#!/bin/bash

# ---------- CONFIGURATION ----------
SOURCE_DIR="/home/user/Documents"               # Folder to back up
DEST_DIR="/home/user/backup"                    # Backup destination
LOGFILE="/var/log/rsync-backup.log"             # Log file path
EMAIL="your_email@example.com"                  # Where to send alerts

RSYNC_OPTS="-avh --delete --exclude='.cache'"

# ---------- START ----------
echo "----------------------------------------" >> "$LOGFILE"
echo "Backup started: $(date)" >> "$LOGFILE"

mkdir -p "$DEST_DIR"

# Run rsync
rsync $RSYNC_OPTS "$SOURCE_DIR/" "$DEST_DIR/" >> "$LOGFILE" 2>&1
STATUS=$?

# Check status and send email
if [ $STATUS -eq 0 ]; then
    SUBJECT="✔ Backup Successful on $(hostname)"
    MESSAGE="Backup completed successfully at $(date).\n\nSource: $SOURCE_DIR\nDestination: $DEST_DIR"
    echo -e "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
    echo "Backup SUCCESS and email sent." | tee -a "$LOGFILE"
else
    SUBJECT="❌ Backup FAILED on $(hostname)"
    MESSAGE="Backup FAILED at $(date).\nCheck log file: $LOGFILE\n\nLast 20 lines of log:\n$(tail -20 $LOGFILE)"
    echo -e "$MESSAGE" | mail -s "$SUBJECT" "$EMAIL"
    echo "Backup FAILED and email sent." | tee -a "$LOGFILE"
fi

echo "Backup finished: $(date)" >> "$LOGFILE"
echo "----------------------------------------" >> "$LOGFILE"
