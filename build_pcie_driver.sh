#!/bin/bash

source config.sh

git clone https://github.com/hailo-ai/hailort-drivers.git

cd hailort-drivers
git checkout "${HAILORT_DRIVER_TAG}"

#cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config release
cd linux/pcie
make all
sudo make install_dkms
sudo modprobe hailo_pci


cd ../.. || exit

./download_firmware.sh
mkdir -p /lib/firmware/hailo/
sudo mv hailo8_fw.${HAILORT_DRIVER_VERSION}.bin /lib/firmware/hailo/hailo8_fw.bin
mkdir -p /etc/udev/rules.d/
sudo cp ./linux/pcie/51-hailo-udev.rules /etc/udev/rules.d/
