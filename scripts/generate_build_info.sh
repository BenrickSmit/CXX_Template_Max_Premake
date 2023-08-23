#!//bin//bash
##------------------------------------------------------------------------------
## SECTION: Special Function declarations for later use.
##------------------------------------------------------------------------------
print_colour() {
  ## This function is necesary for special colours in the output
	if [ "$2" == "RED" ]; then
		printf "${RED}${1}${NC}\n"
	elif [ "$2" == "YELLOW" ]; then
		printf "${YELLOW}${1}${NC}\n"
	elif [ "$2" == "BLUE" ]; then
		printf "${BLUE}${1}${NC}\n"
	elif [ "$2" == "GREEN" ]; then
		printf "${GREEN}${1}${NC}\n"
	else
		printf "$1\n"
	fi
}

test_folder() {
  ## This function is responsible for testing whether the build folder exists
  BUILD_INFO_PATH="./build_info"
  print_colour ">>>> Testing if folder $BUILD_INFO_PATH exists: " "BLUE"

  if [ -d "$BUILD_INFO_PATH" ]; then
    print_colour ">> $BUILD_INFO_PATH EXISTS" "GREEN"
  else
    print_colour "$BUILD_INFO_PATH DOES NOT EXIST" "RED"
    print_colour ">> creating..." "BLUE"
    mkdir build_info
  fi
}

create_build_files() {
  ## This function is responsible for creating the build_information
  print_colour ">>>> Creating Auxilliary Build Files for CMake" "BLUE"
  # Read the .env file line by line and create corresponding files in build_info folder
  while IFS= read -r line; do
    # Ignore lines starting with #
    if [[ "$line" =~ ^# ]]; then
      continue
    fi

    # Extract the property and value to create files from later
    property="${line%%=*}"
    value="${line#*=}"

    # Create the file name from the property
    file_name="build_info/${property}.txt"

    # Write the value to the file
    echo "$value" > "$file_name"
  done < .env
  print_colour ">> Created" "Green"
}


##------------------------------------------------------------------------------
## SECTION: MAIN Execution
##------------------------------------------------------------------------------
print_colour ">>>>>> Starting Process" "YELLOW"
test_folder
create_build_files
print_colour ">>>>>> Finishing Process" "YELLOW"