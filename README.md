# CXX_Template_Max_Premake
This template includes not only OpenGL, but also GProf, Google Testing, and GLFW for application design. It does so with the help of Premake5.

Thus, it is a basic C++ Project template file structure created to help me with sideprojects. It allows the easy creation of libraries, profiling information, tests, and more.

# Description
This is a general C++ template project structure. It comes with automated automated testing (using gtest), automated profiling (using google automated profiling tools) and premake5
to help with the execution. A copy of the executable will be present in the <code>bin/</code> folder.

NOTE: To change any information about the application, use the .env file. The application will then propagate these changes throughout the application as necessary.

<code>generate.sh</code> is used to run premake, clean all files created during the previous run, and then provide the intermediate files
<code>generate_build_info</code> is used to create the build_info directory later used by CMake and Docker. 
PS: If any documents are missing, try torun generate_build_info.sh first, and this should clear up most of the issues, probably.

<code>docker-run.sh</code> is the file to run the image using only the Dockerfile(_CXX)
<code>docker-compose_run.sh</code> is the file used to run the image using docker-compose.yml - this is the preferred way.

<code>init_documentation.sh</code> is used to create the documentation automatically (not yet implemented)
<code>run_all.sh</code> is used to run all tests and program execution, as well as to create the necessary documentation and profile information (needs changing)
<code>run_application.sh</code> is used to run only the application (needs changing)
<code>run_tests.sh</code> is used to run only the tests  (needs changing)
<code>run_profile.sh</code> is used to run only the profiler  (needs changing)

<code>.env</code> is used to change any and all master project settings, from project name, to c++ standard used, and testing.

Find the project [here](https://github.com/BenrickSmit/GeneralCXXTemplate), if you did not find this project on my github.

# Requirements
This will be the requirements for the application to successfully run, here, however, it only requires Docker to be installed, for now.

# Features
This states the current features provided by the program

# Future Changes
This gives information on the future changes that are likely to be implemented.

Currently, still need to fix ImGui settings and enabling Premake to run from scratch via docker.

# How to Run
This gives information on how to normally run the CXX program

# How to Run Unit Tests
This gives information on how to normally run the CXX program's tests

# Key Dependencies
This gives information on the dependencies required by the CXX program

# How to contribute
This states how others can contribute to the project, and what styles to use

# License
This project is under the following [licence](LICENSE).

