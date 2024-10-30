#!/bin/bash

# Show usage function
show_usage() {
    echo "Usage: $0 <directory> <file_extension> [prefix_name]"
    echo "Example:"
    echo "  $0 /path/to/dir png photo    # Renames .png files and their .meta files"
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

# Handle specific extension and meta files
for file in "$dir"/*."$ext"; do
    if [[ -f "$file" ]]; then
        # Rename main file
        temp_name="TEMP_${timestamp}_${counter}.${ext}"
        mv "$file" "$dir/$temp_name"
        echo "Temporary rename: $file -> $temp_name"
        
        # Rename corresponding meta file if it exists
        meta_file="${file}.meta"
        if [[ -f "$meta_file" ]]; then
            temp_meta_name="TEMP_${timestamp}_${counter}.${ext}.meta"
            mv "$meta_file" "$dir/$temp_meta_name"
            echo "Temporary rename: $meta_file -> $temp_meta_name"
        fi
        
        ((counter++))
    fi
done

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
for file in $(ls -v "$dir"/TEMP_${timestamp}_*.${ext}); do
    if [[ -f "$file" ]]; then
        if [[ -n "$prefix" ]]; then
            new_name="${prefix}$(printf "%05d" $counter).${ext}"
        else
            new_name="$(printf "%05d" $counter).${ext}"
        fi
        
        # Rename main file
        mv "$file" "$dir/$new_name"
        echo "Final rename: $(basename "$file") -> $new_name"
        
        # Rename corresponding temporary meta file if it exists
        temp_meta_file="${file}.meta"
        if [[ -f "$temp_meta_file" ]]; then
            mv "$temp_meta_file" "$dir/$new_name.meta"
            echo "Final rename: $(basename "$temp_meta_file") -> $new_name.meta"
        fi
        
        ((counter++))
    fi
done

echo "Renaming completed! Processed $total_files files and their meta files."

