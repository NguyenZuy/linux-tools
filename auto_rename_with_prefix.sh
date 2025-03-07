#!/bin/bash

# Enable debugging
set -x

# Show usage function
show_usage() {
    echo "Usage: $0 <directory> <prefix>"
    echo "Example:"
    echo "  $0 /path/to/dir 1-    # Renames all images in the directory with prefix '1-'"
    exit 1
}

# Check if minimum arguments are provided
if [[ $# -lt 2 ]]; then
    show_usage
fi

# Get arguments
dir="$1"
prefix="$2"

# Check if directory exists
if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist!"
    exit 1
fi

# Supported image extensions
extensions=("jpg" "jpeg" "png" "gif" "bmp" "tiff")

# Counter for sequential numbering
counter=1

# Loop through each supported extension
for ext in "${extensions[@]}"; do
    # Find all files with the current extension
    for file in "$dir"/*."$ext"; do
        if [[ -f "$file" ]]; then
            # Create new name with prefix and sequential number
            new_name="${prefix}$(printf "%05d" $counter).${ext}"
            
            # Rename the file
            mv "$file" "$dir/$new_name"
            echo "Renamed: $(basename "$file") -> $new_name"
            
            # Increment the counter
            ((counter++))
        fi
    done
done

echo "Renaming completed! Processed $((counter - 1)) files."
