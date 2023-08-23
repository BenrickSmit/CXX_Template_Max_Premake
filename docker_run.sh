#//bin//bash

# Docker Image Name
IMAGE_NAME=$(cat ./build_info/BUILD_CXX_APP_NAME.txt)
PROFILER_ON=$(cat ./build_info/BOOL_PERFORMANCE_TEST.txt)

# RUn the Docker container with gperftools


if condition; then
    # No profiler, so just build the application
    docker run -it --rm \
    --name $IMAGE_NAME \
    $IMAGE_NAME

else
    # profiler, so build the application
    docker run -it --rm \
    -e CPUPROFILE=/app/$IMAGE_NAME.prof \
    -v $(pwd)/$IMAGE_NAME.prof:/app/$IMAGE_NAME.prof \
    --name $$IMAGE_NAME \
    $$IMAGE_NAME
fi
