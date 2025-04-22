#!/bin/bash

# Define the number of files to create
num_files=5

# Define the size of each file (e.g., 10M for 10MB files)
file_size="10G"

# Define the source and destination directories
source_dir="."
# destination_dir="/mnthpc/cts-isilon-storage/transfer_speed_test"
destination_dir="./test_local_transfer_speed"

# Create source directory if it doesn't exist
mkdir -p "$source_dir"

# Create destination directory if it doesn't exist
mkdir -p "$destination_dir"

# Create and copy files
for i in $(seq 1 $num_files); do
    file_name="large_file_$i"
    echo "Creating file $file_name of size $file_size"
    
    # Create a file of the specified size
    fallocate -l $file_size "$source_dir/$file_name"
    
    # Copy the file and measure transfer speed
    echo "Copying $file_name to $destination_dir"
    rsync -ah --progress "$source_dir/$file_name" "$destination_dir"
done

# Remove the copied files from the destination directory
echo "Removing files from $destination_dir"
rm -f "$destination_dir"/large_file_*
echo "Removing files from $source_dir"
rm -f "$source_dir"/large_file_*

echo "Task completed."