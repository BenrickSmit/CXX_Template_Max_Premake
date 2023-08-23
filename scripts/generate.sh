#!/bin/bash

# Remove all the solution files
./premake_cleanup.sh

# Create all the files from the .env file
./generate_build_info.sh

# Run premake
./dependencies/premake/premkae5 vs2022