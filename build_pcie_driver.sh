#!/bin/bash

# Determine toolpath if not set already
relativepath="./" # Define relative path to go from this script to the root level of the tool
if [[ ! -v hailo_debian_tool_path ]]; then scriptpath=$(cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd ); hailo_debian_tool_path=$(realpath --canonicalize-missing $scriptpath/$relativepath); fi

# Load Configuration
source "${hailo_debian_tool_path}/config.sh"

# Change Directory to build Subfolder
mkdir -p "${hailo_debian_tool_path}/build"
cd "${hailo_debian_tool_path}/build"

if [[ ! -d "${hailo_debian_tool_path}/build/hailort-drivers" ]]
then
    # Clone Repository
    git clone https://github.com/hailo-ai/hailort-drivers.git
fi

# Change Directory to hailort Subfolder
cd hailort-drivers

# Fetch the latest Changes
git fetch --all

# Checkout the desired Tag
git checkout "tags/${HAILORT_DRIVER_TAG}"

# Change Directory to linux/pcie Subfolder
cd linux/pcie

# Start from a Clean State: remove old Build Files
make clean

# Build Driver
make all

# Install using DKMS
sudo make install_dkms

# Load the Kernel Driver
sudo modprobe hailo_pci

# Change to Tool Root Folder
cd "${hailo_debian_tool_path}" || exit
# cd ../.. || exit

# Download Firmware
source "download_firmware.sh"

# Create Firmware Folder if it doesn't exist yet
mkdir -p /lib/firmware/hailo/

# Copy Firmware to /lib/firmware/hailo/hailo8_fw.bin
cp "${hailo_debian_tool_path}/firmware/hailo8_fw.${HAILORT_DRIVER_VERSION}.bin" /lib/firmware/hailo/hailo8_fw.bin

# Create UDEV Rules Folder if not existing already
mkdir -p /etc/udev/rules.d/

# Copy UDEV Rules for Hailo Device
cp "${hailo_debian_tool_path}/build/hailort-drivers/linux/pcie/51-hailo-udev.rules" /etc/udev/rules.d/

# Update InitramFS
update-initramfs -k all -u
