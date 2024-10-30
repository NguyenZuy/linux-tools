#!/bin/bash

# Check if both directory and file type are provided
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <directory> <file_extension>"
  echo "Example: $0 /path/to/dir jpg"
  exit 1
fi

# Get directory and file extension from arguments
dir="$1"
ext="$2"

# Initialize the counter
counter=1

# Find all files with the given extension and rename them sequentially
for file in "$dir"/*."$ext"; do
  if [[ -f "$file" ]]; then
    # Generate new name with 5-digit zero padding (e.g., 00001.jpg)
    new_name=$(printf "%05d.%s" "$counter" "$ext")

    # Rename the file
    mv "$file" "$dir/$new_name"

    # Increment the counter
    ((counter++))
  fi
done

echo "Renaming completed!"

