# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for Node development using Windows and Linux native tools

Disable-UAC

$user = "Microsoft";
$baseBranch = "master";
$finalBaseHelperUri = "https://raw.githubusercontent.com/$user/Dev-Advocacy-Samples/$baseBranch/scripts";

#--- Dev tools ---
write-host "Downloading VS Code ..."
choco install -y vscode
write-host "Downloading git ..."
choco install -y git -params '"/GitAndUnixToolsOnPath /WindowsTerminal"'
write-host "Enabling WSL ..."
choco install -y Microsoft-Windows-Subsystem-Linux -source windowsfeatures

# We must reboot before installing the distro.  
# Check if reboot wasn't performed automatically for us
if (Test-PendingReboot)
{ Invoke-Reboot }

#--- Ubuntu ---
write-host "Installing Ubuntu 18.04 ..."
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with a blank root user
Ubuntu1804 install --root

write-host "Downloading Node samples to your desktop ..."
Update-SessionEnvironment
cd $env:USERPROFILE\desktop
git clone https://github.com/Microsoft/Dev-Advocacy-Samples

## Install tools inside the WSL distro
write-host "Installing tools inside the WSL distro..."
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y
## Node.js tools
Ubuntu1804 run touch ~/.bashrc
Ubuntu1804 run curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash

write-host "Please continue with project setup by following the steps in the project readme"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula