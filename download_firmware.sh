#!/bin/bash

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v hailo_debian_tool_path ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); hailo_debian_tool_path=$(realpath --canonicalize-missing $scriptpath/$relativepath); fi

# Load Configuration
source "${hailo_debian_tool_path}/config.sh"

# Create Subfolder if it doesn't exist
mkdir -p "${hailo_debian_tool_path}/firmware"

# Change Directory to firmware Subfolder
cd "${hailo_debian_tool_path}/firmware"

# Define URL Source
url_source="https://hailo-hailort.s3.eu-west-2.amazonaws.com/Hailo8/${HAILORT_DRIVER_VERSION}/FW/hailo8_fw.${HAILORT_DRIVER_VERSION}.bin"

# Echo
echo "Downloading Firmware Version ${HAILORT_DRIVER_VERSION} from ${url_source} ..."

# Download Firmware
wget -N "https://hailo-hailort.s3.eu-west-2.amazonaws.com/Hailo8/${HAILORT_DRIVER_VERSION}/FW/hailo8_fw.${HAILORT_DRIVER_VERSION}.bin"
