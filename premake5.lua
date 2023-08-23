-- premake5.lua
 
-- This part of the master premake will be responsible for creating functions
-- for later use, particularly if you need to read something from the .env file.

-- Define colour_c codes
local COLOUR_RESET = "\27[0m"
local COLOUR_RED = "\27[31m"
local COLOUR_GREEN = "\27[32m"
local COLOUR_YELLOW = "\27[33m"
local COLOUR_BLUE = "\27[34m"
local COLOUR_WHITE = "\27[37m" -- New white colour_c code

-- Function to print colour text
function print_colour(colour_c, text, line_break)
    line_break = line_break or "\n"
    local colour_code
    if colour_c == "red" then
        colour_code = COLOUR_RED
    elseif colour_c == "green" then
        colour_code = COLOUR_GREEN
    elseif colour_c == "yellow" then
        colour_code = COLOUR_YELLOW
    elseif colour_c == "blue" then
        colour_code = COLOUR_BLUE
    elseif colour_c == "white" then
        colour_code = COLOUR_WHITE
    else
        colour_code = ""
    end

    -- Print colour_ced text
    io.write(colour_code .. (text) .. COLOUR_RESET .. line_break)
end

-- Application Storage
-- Read a values from a files and store them in Premake variables
print_colour("blue", "Starting Premake")
print_colour("blue", "==========================================================")
print_colour("blue", "Reading Values From File")
print_colour("blue", "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")
print_colour("blue", "PS: To Change Project Values Change them in the .env  file")
print_colour("blue", "++++++++++++++++++++++++++++++++++++++++++++++++++++++++++")

workspace_name = io.open("build_info/BUILD_CXX_WORKSPACE_NAME.txt"):read("*line")
print_colour("green", "Workspace Name: ", "")
print_colour("yellow", "" .. workspace_name)
project_name = io.open("build_info/BUILD_CXX_APP_NAME.txt"):read("*line")
print_colour("green", "Project Name: ", "")
print_colour("yellow", "" .. project_name)
workspace_version = io.open("build_info/BUILD_CXX_APP_VERSION.txt"):read("*line")
print_colour("green", "Project Version: ", "")
print_colour("yellow", "" .. workspace_version)
workspace_standard = io.open("build_info/BUILD_CXX_APP_STANDARD_VERSION.txt"):read("*line")
print_colour("green", "C++ Standard: ", "")
print_colour("yellow", "" .. workspace_standard)
workspace_testing = io.open("build_info/BOOL_CREATE_TESTS.txt"):read("*line")
print_colour("green", "Application Testing: ", "")
print_colour("yellow", "" .. workspace_testing)
workspace_profiling = io.open("build_info/BOOL_PERFORMANCE_TEST.txt"):read("*line")
print_colour("green", "Application Profiling: ", "")
print_colour("yellow", "" .. workspace_profiling)

bool_log_information = io.open("build_info/BOOL_LOG_INFORMATION.txt"):read("*line")
print_colour("green", "LOG Information: ", "")
print_colour("yellow", "" .. bool_log_information)
print_colour("white", " Note: This will set a global variable that can be used")
print_colour("white", "       to display log information")
print_colour("blue", "==========================================================\n")


-- Workspace Declaration
-- This is the equivalent to a solution name in Visual Studio; CMake doesn't 
-- really have an equivalent
workspace (workspace_name)
    configurations {"Debug","Release", "Dist"}
    architecture "x64"
    -- states what project to start with should you have a large group of them
    -- startproject "project-name"

-- Set up specialised output directory for the application, changable later
output_dir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root directory for additional libraries
include_dirs = {}
include_dirs["GLFW"] = "dependencies/GLFW/include"
include_dirs["GLAD"] = "dependencies/GLAD/include"
include_dirs["GoogleTest"] = "dependencies/GoogleTest/googletest/include"
include_dirs["ImGui"] = "dependencies/ImGui/"
-- include_dirs["glm"] = ""

include "dependencies/GLFW"
include "dependencies/GLAD"
include "dependencies/GoogleTest"
include "dependencies/ImGui"

-- This is the project name, and will also be the library name. Unless you're 
-- making something like a game engine, this will generally be just one project 
-- name. This project will include the libraries, etc. That the project will 
-- need to run, so treat it as such.
project (project_name)
    -- This can be set to a folder name, should you seperate all the information
    -- into different folders for each project. For now, it's the root location.
    -- Thus all the project solutions will be created in this folder
    location "/"

    -- ConsoleApp/SharedLib/StaticLib/etc
    kind "ConsoleApp"
    language "C++"
    cppdialect ("C++" .. workspace_standard)
    staticruntime "off"     -- true if staticlib
    -- This will output the files to "bin/Debug" or "bin/Release", etc
    -- targetdir "bin/%{cfg.buildcfg}"
    targetdir ("bin/" .. output_dir .. "/%{prj.name}")
    -- Intermediate directory for the .obj files
    objdir ("bin-int/" .. output_dir .. "/%{prj.name}")

    -- Should you have a precompiled header file - i.e. a header file that 
    -- contains all the includes that your project might need now and in the
    -- future, use the following:
    -- pchheader "filename.h"
    -- pchsource "src/filename.cpp"

    -- This will look for all the files in include, and src and include them
    -- down to this application. Should you have changed it to a different
    -- project and have different names for each application, then the best 
    -- would be one of the following: 
    -- 
    -- Should you have different project names and include and src, e.g.
    -- project_name1/include & project_name1/src
    -- add in "%{prj.name}/src/**cpp", "%{prj.name}/include/**.h"
    --
    -- Should you have changed it to the following where each solution is in
    -- a different directory in src or include, then
    -- add in "include/%{prj.name}/**.h", "src/%{prj.name}/**.cpp"
    files {
        "include/**.h", 
        "src/**.c", 
        "src/**.cpp", 
        "src/**.cxx",
        "include/TestingClass.h",
        "src/TestingClass.cpp"
    }

    -- This is for different alternatives, and libraries being used, such as 
    -- boost, opengl, vulkan, spdlog, etc
    includedirs{
        "include",
        "src",
        -- necessary if you separate the files by project instead:
        -- "%{prj.name}/src",
        "%{include_dirs.GLFW}",
        "%{include_dirs.GLAD}",
        "%{include_dirs.ImGui}"
    }

    -- Used to link in different libraries, such as OpenGL, Boost, etc
    links {
        "GLFW",
        "GLAD",
        "ImGui",
        "opengl32.lib"
    }

    -- This is a project-specific defines that will enable debugging via
    -- a global definition
    defines {
        "BOOL_LOG_INFO=" .. bool_log_information,
    }

    -- Windows Specific Filter
    filter "system:windows"
        -- This is on a case-by-case basis and can cause trouble later on
        systemversion "latest"

        -- Windows specific defines
        defines {
            "GLFW_INCLUDE_NONE"
        }

        -- Something to run every time you finish the building of the project
        postbuildcommands {

        }

    -- Linux Specific Filter
    filter "system:linux"
        -- Linux specific defines
        defines {
            "GLFW_INCLUDE_NONE"
        }

        -- Something to run every time you finish the building of the project
        postbuildcommands {
            -- e.g. ("{COPY} %{cfg.buildtarget.relpath} ../bin/" .. output_dir .. "/{prj.name}")
        }

    -- Debug Specific Filters
    filter "configurations:Debug"
        defines {"Debug"}
        symbols "On"

    -- Release Sepecific Filters
    filter "configurations:Release"
        defines {"Release"}
        optimize "On"

    -- Dist Specific Filters
    filter "configurations:Dist"
        defines {"Dist"}
        optimize "On"

    -- Link ImGui and other libraries
    filter { "system:windows", "configurations:Debug" }
    links { "ImGui", }

    filter { "system:windows", "configurations:Release" }
    links { "ImGui",}


-- Conditional activation, i.e. only activate if they have been specified 
-- in the .env file
if workspace_testing == "ON" then
    -- Include the test project setup
    project ("" .. workspace_name .. "-tests")
    location ""
    kind "ConsoleApp"
    language "C++"
    staticruntime "on"
    
    -- This will output the files to "bin/Debug" or "bin/Release", etc
    -- targetdir "bin/%{cfg.buildcfg}"
    targetdir ("bin/" .. output_dir .. "/%{prj.name}-tests")
    -- Intermediate directory for the .obj files
    objdir ("bin-int/" .. output_dir .. "/%{prj.name}-tests")
    
    files
    {
        "include/TestingClass.h", 
        "src/TestingClass.cpp",
        "test/main.cpp",
        "test/tests_main.cpp",
    }

    includedirs
    {
        "gtest",
        "%{include_dirs.GoogleTest}",
        "include",
        "src",
        "test",
        
    }
    links { "gtest" }

end
