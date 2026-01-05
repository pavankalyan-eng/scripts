#!/bin/bash

# -------------------- CONFIG --------------------
FILE1="pavan"
FILE2="kalyan"
DIR="linuxx"

# -------------------- SCRIPT START --------------------

echo "Starting file operations..."

# 1. Create a directory
echo "Creating directory: $DIR"
mkdir -p "$DIR"

# 2. Create files
echo "Creating files: $FILE1 and $FILE2"
echo "This is file1" > "$DIR/$FILE1"
echo "This is file2" > "$DIR/$FILE2"

# 3. List files
echo "Files inside $DIR:"
ls -l "$DIR"

# 4. Copy a file
echo "Copying $FILE1 to copy_of_file1.txt"
cp "$DIR/$FILE1" "$DIR/copy_of_file1.txt"

# 5. Move/rename a file
echo "Renaming $FILE2 to renamed_file2.txt"
mv "$DIR/$FILE2" "$DIR/renamed_file2.txt"

# 6. Check if a specific file exists
if [ -f "$DIR/$FILE1" ]; then
    echo "$FILE1 exists."
else
    echo "$FILE1 does not exist."
fi

# 7. Delete a file
echo "Deleting copy_of_file1.txt"
rm "$DIR/copy_of_file1.txt"

# 8. Display final file list
echo "Final files inside $DIR:"
ls -l "$DIR"

echo "File operations completed."
