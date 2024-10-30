#!/bin/bash

# Show usage function
show_usage() {
    echo "Usage: $0 <directory> <file_extension> [prefix_name]"
    echo "Example:"
    echo "  $0 /path/to/dir jpg photo    # Renames .jpg files to photo00001.jpg, photo00002.jpg, etc."
    echo "  $0 /path/to/dir .  photo     # Renames all files to photo00001.ext (keeps original extension)"
    exit 1
}

# Check if minimum arguments are provided
if [[ $# -lt 2 ]]; then
    show_usage
fi

# Get arguments
dir="$1"
ext="$2"
prefix="${3:-}"  # If prefix is not provided, it will be empty

# Check if directory exists
if [[ ! -d "$dir" ]]; then
    echo "Error: Directory '$dir' does not exist!"
    exit 1
fi

# Create a unique timestamp for temporary filenames
timestamp=$(date +%s)

# First phase: Rename all files to temporary names
echo "Phase 1: Creating temporary names..."
counter=1

if [[ "$ext" == "." ]]; then
    # Handle all files
    for file in "$dir"/*; do
        if [[ -f "$file" && "$(basename "$file")" != "$(basename "$0")" ]]; then
            ext="${file##*.}"
            temp_name="TEMP_${timestamp}_${counter}.${ext}"
            mv "$file" "$dir/$temp_name"
            echo "Temporary rename: $file -> $temp_name"
            ((counter++))
        fi
    done
else
    # Handle specific extension
    for file in "$dir"/*."$ext"; do
        if [[ -f "$file" ]]; then
            temp_name="TEMP_${timestamp}_${counter}.${ext}"
            mv "$file" "$dir/$temp_name"
            echo "Temporary rename: $file -> $temp_name"
            ((counter++))
        fi
    done
fi

# Store total number of files
total_files=$((counter - 1))

if [ $total_files -eq 0 ]; then
    echo "No files found to rename"
    exit 0
fi

# Second phase: Rename from temporary names to final names
echo "Phase 2: Creating final names..."
counter=1

# Sort temporary files to ensure sequential order
for file in $(ls -v "$dir"/TEMP_${timestamp}_*); do
    if [[ -f "$file" ]]; then
        ext="${file##*.}"
        if [[ -n "$prefix" ]]; then
            new_name="${prefix}$(printf "%05d" $counter).${ext}"
        else
            new_name="$(printf "%05d" $counter).${ext}"
        fi
        
        mv "$file" "$dir/$new_name"
        echo "Final rename: $(basename "$file") -> $new_name"
        ((counter++))
    fi
done

echo "Renaming completed! Processed $total_files files."
