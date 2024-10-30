#!/bin/bash

# Check if directory is provided
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <directory>"
  echo "Example: $0 /path/to/dir"
  exit 1
fi

# Get the directory from the arguments
dir="$1"

# Loop through each file in the directory
for file in "$dir"/*; do
  if [[ -f "$file" ]]; then
    # Define the output .png file path
    output_file="${file%.*}.png"

    # Convert the file to .png format
    convert "$file" "$output_file"

    # Check if the conversion was successful
    if [[ $? -eq 0 ]]; then
      echo "Converted $file to $output_file"
    else
      echo "Failed to convert $file"
    fi
  fi
done

echo "Conversion to PNG completed!"

