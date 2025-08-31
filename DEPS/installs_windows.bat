Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux 
wsl --update
wsl --set-default-version 2
wsl --install -d Ubuntu-22.04
winget install --interactive --exact dorssel.usbipd-win