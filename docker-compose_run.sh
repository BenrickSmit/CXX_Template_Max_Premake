#!//bin//bash

# Your Docker Compose project name
COMPOSE_PROJECT_NAME=$(cat build_info/BUILD_CXX_APP_NAME.txt)

# Create the build files
./scripts/generate_build_info.sh

# Run Docker Compose
docker-compose -p $COMPOSE_PROJECT_NAME up
