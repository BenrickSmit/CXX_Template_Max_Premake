@echo off
setlocal enabledelayedexpansion

:: Special Function declarations for later use.
:print_colour
  REM This function is necessary for special colors in the output.
  SET "message=%~1"
  SET "color=%~2"
  IF "%color%"=="RED" (
    COLOR CF
  ) ELSE IF "%color%"=="YELLOW" (
    COLOR E6
  ) ELSE IF "%color%"=="BLUE" (
    COLOR 1F
  ) ELSE IF "%color%"=="GREEN" (
    COLOR 2A
  ) ELSE (
    COLOR 07
  )
  ECHO !message!
  COLOR 07
  EXIT /B

:test_folder
  REM This function is responsible for testing whether the build folder exists.
  SET "BUILD_INFO_PATH=./build_info"
  CALL :print_colour ">>>> Testing if folder %BUILD_INFO_PATH% exists: " "BLUE"

  IF EXIST "%BUILD_INFO_PATH%" (
    CALL :print_colour ">> %BUILD_INFO_PATH% EXISTS" "GREEN"
  ) ELSE (
    CALL :print_colour "%BUILD_INFO_PATH% DOES NOT EXIST" "RED"
    CALL :print_colour ">> creating..." "BLUE"
    mkdir build_info
  )
  EXIT /B

:create_build_files
  REM This function is responsible for creating the build_information.
  CALL :print_colour ">>>> Creating Auxilliary Build Files for CMake" "BLUE"
  FOR /F "usebackq delims=" %%a IN (".env") DO (
    REM Ignore lines starting with #
    SET "line=%%a"
    SETLOCAL enabledelayedexpansion
    SET "first_chars=!line:~0,1!"
    IF "!first_chars!"=="#" (
      ENDLOCAL
      CONTINUE
    )

    REM Extract the property and value to create files from later.
    SET "property=!line:~0,8!"
    SET "value=!line:~9!"

    REM Create the file name from the property.
    SET "file_name=build_info\!property!.txt"

    REM Write the value to the file.
    ECHO !value!>"!file_name!"
    ENDLOCAL
  )
  CALL :print_colour ">> Created" "GREEN"
  EXIT /B

:: MAIN Execution
CALL :print_colour ">>>>>> Starting Process" "YELLOW"
CALL :test_folder
CALL :create_build_files
CALL :print_colour ">>>>>> Finishing Process" "YELLOW"
