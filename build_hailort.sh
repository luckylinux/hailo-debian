#!/bin/bash

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v hailo_debian_tool_path ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); hailo_debian_tool_path=$(realpath --canonicalize-missing $scriptpath/$relativepath); fi

# Load Configuration
source "${hailo_debian_tool_path}/config.sh"

# Change Directory to build Subfolder
mkdir -p "${hailo_debian_tool_path}/build"
cd "${hailo_debian_tool_path}/build"

if [[ ! -d "${hailo_debian_tool_path}/build/hailort" ]]
then
    # Clone Repository
    git clone https://github.com/hailo-ai/hailort.git
fi

# Change Directory to hailort Subfolder
cd "hailort"

# Fetch the latest Changes
git fetch --all

# Checkout the desired Tag
git checkout "tags/${HAILORT_RUNTIME_TAG}"

# Build only
# cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config release

# Build & install to the Machine
cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && sudo cmake --build build --config release --target install
