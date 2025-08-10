# hailo-debian
Hailo Setup Scripts for Debian

# Clone Repository
Run
```
git clone https://github.com/luckylinux/hailo-debian.git
```
 
# Requirements
## Install Kernel Headers
Vanilla Debian (**NOT** Proxmox VE) - Adjust for your relevant Architecture:
```
apt-get install linux-headers-amd64
```

Proxmox VE:
```
apt-get install proxmox-headers-6.14 proxmox-headers-$(uname -r)
```

## Workaround for Issues on Proxmox VE 9 / Debian Trixie
For some Reason, after upgrading to Debian Trixie, there might be an Issue where the **installed** Proxmox VE Headers cannot be found.

This can be observed with the following Error Mesage:
```
root@HOST:/usr/src/hailo# make clean
make[1]: Entering directory '/usr/lib/modules/6.14.8-2-pve/build'
make[1]: *** No rule to make target 'clean'.  Stop.
make[1]: Leaving directory '/usr/lib/modules/6.14.8-2-pve/build'
make: *** [Makefile:106: clean] Error 2
******************************************************************************
Kernel version: 6.14.8-2-pve
******************************************************************************
make[1]: Entering directory '/usr/lib/modules/6.14.8-2-pve/build'
make[1]: *** No rule to make target 'modules'.  Stop.
make[1]: Leaving directory '/usr/lib/modules/6.14.8-2-pve/build'
make: *** [Makefile:99: all] Error 2
Creating symlink /var/lib/dkms/hailo_pci/5.0.0/source -> /usr/src/hailo_pci-5.0.0

Error! Your kernel headers for kernel 6.14.8-2-pve cannot be found at /lib/modules/6.14.8-2-pve/build or /lib/modules/6.14.8-2-pve/source.
Please install the linux-headers-6.14.8-2-pve package or use the --kernelsourcedir option to tell DKMS where it's located.
```

This can be fixed by manually Symlinking the `/lib/modules/$(uname -r)/build` Folder to  `/usr/src/$(uname -r)`:
```
cd /lib/modules/$(uname -r)
ln -s /usr/src/linux-headers-$(uname -r) build
```

After that, just run:
```
./build_pcie_driver.sh
```

# Install
## Configure what Versions you want
Edit the `config.sh` File and set the Variablees according to your Requirements.

## Install HailoRT
Run
```
./build_hailort.sh
```

## Install Hailo Drivers & Firmware
Run
```
./build_pcie_driver.sh
```
