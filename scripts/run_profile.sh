#!/bin/bash

##-------------------------------------------------------------------------------------------------
## HEADER INFORMATION
##-------------------------------------------------------------------------------------------------
## This Shell Script is used to obtain the program filename from build_name.txt in build_info
## after which it will execute it with gprof, profiling the program for heatmaps.


##-------------------------------------------------------------------------------------------------
## SECTION: FUNCTION DECLARATIONS
##-------------------------------------------------------------------------------------------------
have_prog() {
    [ -x "$(which $1)" ]
}


##-------------------------------------------------------------------------------------------------
## SECTION: PROGRAM LOGIC
##-------------------------------------------------------------------------------------------------
SOURCE_FILENAME="${PWD}/../build_info/BUILD_CXX_APP_NAME.txt"
EXEC_FILENAME=$(cat $SOURCE_FILENAME)
EXEC_FILENAME=${EXEC_FILENAME}
RED=$(tput setaf 1)
GREEN=$(tput setaf 10)
NC=$(tput sgr0)

## Run pprof on the program created
cd build/src/

## Run the program with pprof to generate CPU profile
CPUPROFILE=$(pwd)/${EXEC_FILENAME}.prof ./${EXEC_FILENAME}

## Determine whether the CPU profile file exists
if [ -f ${EXEC_FILENAME}.prof ]; then
    pprof --text ./${EXEC_FILENAME} ${EXEC_FILENAME}.prof > ${EXEC_FILENAME}_profile_info.txt
    cat ${EXEC_FILENAME}_profile_info.txt
else
    echo "${RED}Profile Information Does NOT Exist.${NC}"
    echo "${RED}'pprof' might not be installed, or profiling information was not generated.${NC}"
    echo "${RED}Continuing...${NC}"
fi

