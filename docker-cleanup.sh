#!/bin/bash

# Colors for the output
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
WHITE=$(tput setaf 7)
CYAN=$(tput setaf 6)
NC=$(tput sgr0) # No color

echo "${NC}Docker Cleanup"
echo "-------------------------"

DANGLING_IMAGES=$(docker images -f "dangling=true" -q)

# Run rmi command if there are dangling images
if [ -n "$DANGLING_IMAGES" ]; then
    echo "🧹 Cleaning up dangling images..."
    docker rmi $DANGLING_IMAGES || {
        echo "${RED}Failed to remove dangling images. You may need to remove them manually.${NC}"
    }
else
    echo "${GREEN}No dangling images to clean${NC}"
fi
DANGLING_VOLUMES=$(docker volume ls -qf dangling=true)
# Run volume rm command if there are dangling volumes
if [ -n "$DANGLING_VOLUMES" ]; then
    echo "🧹 Cleaning up dangling volumes..."
    docker volume rm $DANGLING_VOLUMES || {
        echo "${RED}Failed to remove dangling volumes. You may need to remove them manually.${NC}"
    }
else
    echo "${GREEN}No dangling volumes to clean${NC}"
fi
echo "${GREEN}Cleanup complete${NC}"