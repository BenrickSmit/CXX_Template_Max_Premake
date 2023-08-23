@echo off

:: Actual codeto execute

set CMAKE_GENERATOR="Visual Studio 17 2022"   REM Update to your installed Visual Studio version
set BUILD_DIR=build
set BUILD_INFO_DIR=build_info

echo >>>>>> Building CMake project...

if not exist %BUILD_DIR% mkdir %BUILD_DIR%
cd %BUILD_DIR%

if not exist %BUILD_INFO_DIR% mkdir %BUILD_INFO_DIR%
call .\scripts\generate_build_info.cmd

cmake -G %CMAKE_GENERATOR% ..
if %errorlevel% neq 0 (
    echo >>>>>>  CMake configuration failed.
    exit /b 1
)

set /p RELEASE_TRUE=<build_info\BUILD_CXX_APP_TYPE.txt

cmake --build . --config %RELEASE_TRUE%
if %errorlevel% neq 0 (
    echo >>>>  Build failed.
    exit /b 1
)

echo >>>>>>  Build successful!

set /p APP_NAME=<build_info\BUILD_CXX_APP_NAME.txt
set EXECUTABLE=%APP_NAME%.exe

if exist %EXECUTABLE% del %EXECUTABLE%
move Release\%EXECUTABLE% .

echo >>>>>>  Executable created: %EXECUTABLE%

pause
