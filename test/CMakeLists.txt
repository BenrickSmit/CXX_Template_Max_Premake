file(STRINGS "../build_info/BOOL_LOG_INFORMATION.txt" BOOL_LOG_INFORMATION)


##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
## SECTION: Function Declarations for use
##++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
function(log_message VAR_NAME MESSAGE)
    # Ensure Colour Use
    if(WIN32)
        # Windows doesn't natively support ANSI escape codes
        set(COLOUR_RESET "")
        set(COLOUR_RED "")
        set(COLOUR_GREEN "")
        set(COLOUR_YELLOW "")        

    else()
        # ANSI escape codes for COLOUR
        #set(COLOUR_RESET "\033[0m")
        #set(COLOUR_RED "\033[1;31m")
        #set(COLOUR_GREEN "\033[1;32m")
        #set(COLOUR_YELLOW "\033[1;33m")
        set(COLOUR_RESET "${Esc}[m")
        set(COLOUR_RED "${Esc}[31m")
        set(COLOUR_GREEN "${Esc}[32m")
        set(COLOUR_YELLOW "${Esc}[33m")
    endif()

    if(${VAR_NAME})
        message(STATUS "${COLOUR_GREEN} >> ${MESSAGE} << ${COLOUR_RESET}")
    endif()
endfunction()





# Create your test executables here
add_executable(test_executable tests_main.cpp)

# Link against necessary libraries
target_link_libraries(test_executable PUBLIC glew glfw ${OPENGL_LIBRARIES})

# Include directories
target_include_directories(test_executable PUBLIC ${DEPENDENCIES_DIR}/GLFW/include)
target_include_directories(test_executable PUBLIC ${DEPENDENCIES_DIR}/GLEW/include)
target_include_directories(test_executable PUBLIC ${DEPENDENCIES_DIR}/GoogleTest/googletest/include)
target_include_directories(test_executable PUBLIC ${CMAKE_SOURCE_DIR}/include)  # Add your own include directory if needed











