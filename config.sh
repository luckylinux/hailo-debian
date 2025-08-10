#!/bin/bash

# **IMPORTANT**: see the Warning at https://github.com/hailo-ai/hailort-drivers
# >> Note: The master branch supports only the Hailo-10 and Hailo-15 device families. For Hailo-8, Hailo-8R, and Hailo-8L devices, please use the hailo8 branch.
#
# As such, version 5.0.0 seems to only be applicable to Hailo-10 and Hailo-15 Device Families. No Firmware for Hailo-8 of Version 5.0.0 can be downloaded anyways.

# Hailo Device
HAILO_DEVICE_TYPE=8

# Define HailoRT Driver Version
#HAILORT_DRIVER_VERSION="4.19.0"
HAILORT_DRIVER_VERSION="4.21.0" # Works with Frigate 0.16.x-rc3
#HAILORT_DRIVER_VERSION="4.22.0"
#HAILORT_DRIVER_VERSION="5.0.0" # Hailo10 only !
HAILORT_DRIVER_TAG="v${HAILORT_DRIVER_VERSION}"

# Define HailoRT Runtime Version
#HAILORT_RUNTIME_VERSION="4.19.0"
HAILORT_RUNTIME_VERSION="4.21.0" # Works with Frigate 0.16.x-rc3
#HAILORT_RUNTIME_VERSION="4.22.0"
#HAILORT_RUNTIME_VERSION="5.0.0" # Hailo10 only !
HAILORT_RUNTIME_TAG="v${HAILORT_RUNTIME_VERSION}"
