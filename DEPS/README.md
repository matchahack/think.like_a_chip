# Loading our designs onto the FPGA

For this we need specialised softwares: [this installation and build guide](https://learn.lushaylabs.com/os-toolchain-manual-installation/) targets our device - the 'Gow1n' `FPGA (field programmable gate array)` on-board the TangNano. It covers Windows, Mac and Linux in fairly good detail, and is open source.

If TLDR; Try running the following...

## Installs for the FPGA toolchain in Windows

0. Open `Powershell` terminal as admin

1. Install tools: `wsl` for linux-like dev environment, and `usbipd` to tunnel your FPGA programmer through Windows to WSL
```
.\installs_windows.bat
```

2. Attach your USB to Linux through Windows
```
usbipd attach --wsl --busid <your_device_BUSID>
```

3. Open a `wsl-2` terminal, and run the Ubuntu script...
```
wsl
```

## Installs for the FPGA toolchain in Linux (Ubuntu)

0. Install all FPGA programming tools
```
chmod a+x *.sh
sudo ./installs_linux.sh
chmod a+x *.sh
```

## Installs for the FPGA toolchain in Mac

> [!WARNING]
> This install section (for IOS) is not tested

0. Install all FPGA programming tools

```
chmod a+x *.sh
./installs_mac.sh
chmod a+x *.sh
```