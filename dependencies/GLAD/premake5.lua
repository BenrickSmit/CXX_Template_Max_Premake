-- GLAD setup
project "GLAD"
    kind "StaticLib"
    language "C"
    staticruntime "on"

    targetdir ("bin/" .. output_dir .. "/%{prj.name}")
    objdir ("bin-int/" .. output_dir .. "/%{prj.name}")

    files {
        "include/glad/glad.h",
        "include/KHR/khrplatform.h",
        "src/glad.c"
    }

    includedirs{
        "include"
    }

    filter "system:windows"
        systemversion "latest"

    filter {"system:windows", "configurations:Release"}
        buildoptions "/MT"