project "gtest"
    location "dependencies/GoogleTest"
    language "C++"
    kind "StaticLib"
    staticruntime "on"

    targetdir ("bin/" .. output_dir .. "/%{prj.name}")
    objdir ("bin-int/" .. output_dir .. "/%{prj.name}")

    includedirs { 
        -- "googletest/include",
        -- "googletest/include/gtest",
        -- "googletest/include/gtest/internal",
        -- "googletest/include/gtest/internal/custom",
        -- "googletest/src",
        "googletest/",
        "googletest/include",
        "googletest/include/gtest",
    }
    
    files { 
        "googletest/src/gtest-all.cc",
        -- "googletest/include/gtest/**.h",
        -- "googletest/src/**.h",
        -- "googletest/src/**.cc",
    }

    filter "system:windows"
        systemversion "latest"

    filter { "system:linux" }
        linkoptions "-pthread"


    