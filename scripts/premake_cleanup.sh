#!/bin/bash

# Function to delete bin and bin-int folders
delete_bin_folders() {
    find "$1" -type d \( -name "bin" -o -name "bin-int" \) -exec rm -r {} \;
}

# Function to delete recently generated VS2022 solution files
delete_recent_sln_files() {
    find "$1" -type f \( -name "*.sln" -o -name "*.vcxproj" -o -name "*.vcxproj.user" -o -name "*.vcxproj.filters" \) -exec rm {} \;
}

# Specify the root directory of your project
project_root="."

# Call the function to delete bin and bin-int folders
delete_bin_folders "$project_root"

# Call the function to delete recently generated VS2022 solution files
delete_recent_sln_files "$project_root"
