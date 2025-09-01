# Loading our designs onto the FPGA

## Install Windows-WSL

> [!NOTE]
> If you have not installed wsl-2, then follow this section first. All commands should be executed from `Powershell` as Admin. You may need to restart your PC for these changes to take effect.

0. Type `Powershell` into the search bar, right click, and select `Run as Admin`

1. Run the following to install `wsl` and `usbipd` to tunnel your FPGA programmer through Windows to WSL. Follow the prompts.
```
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux 
wsl --update
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
```

2. If you have not already got a `wsl` terminal open, open a powershell terminal and type:
```
wsl
```

3. Open a new Powershell terminal to attach your USB to Linux through Windows:
```
winget install --interactive --exact dorssel.usbipd-win
usbipd list
usbipd bind --busid <your_device_BUSID>
usbipd attach --wsl --busid <your_device_BUSID>
```

## Install USB support in WSL

0. In `wsl` terminal, follow any prompts

1. Install all FPGA programming tools, follow any prompts
```
sudo apt-get update && sudo apt-get upgrade && \
sudo apt-get install make build-essential libssl-dev zlib1g-dev libftdi1-2 libftdi1-dev libhidapi-hidraw0 libhidapi-dev git libudev-dev zlib1g-dev linux-tools- linux-cloud-tools-generic -y
```

2. Set up git
```
git clone https://github.com/matchahack/think.like_a_chip.git
```

3. Find out what the name of the USB is in WSL:
```
ls /dev/
```

## Install Docker

> [!NOTE]
> If you do not have Docker installed, then [install docker desktop](https://www.docker.com/). This might log you out in order for changes to take effect.

0. When docker is installed, follow any prompts.

1. To build your docker image, run the following in your `wsl` terminal:
```
cd /home/$USER/think.like_a_chip/
docker build --no-cache -t bsides_bristol_matchahack_img .
```

> [!WARNING]
> If at some step this fails, then run again from the last checkpoint using: `docker build -t bsides_bristol_matchahack_img .`

2. To spin-up your docker container in order to build FPGA Bitstreams, run the following in your:
```
docker images
docker run -it --privileged --device=/dev/ttyUSB1 <IMAGE_ID>
```

## Build and test a bitstream

> [!IMPORTANT]
> Now follow the guide in [1_BLINK](../1_BLINK/README.md)