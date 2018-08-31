# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for machine learning using Windows and Linux native tools

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

write-host "Downloading Python ML samples to your desktop ..."
Update-SessionEnvironment
cd $env:USERPROFILE\desktop
git clone https://github.com/Microsoft/Dev-Advocacy-Samples

# TODO: now install additional ML tools inside the WSL distro once default user w/blank password is working
write-host "Installing tools inside the WSL distro..."
Ubuntu1804 run apt update
Ubuntu1804 run apt upgrade -y
## Python tools
Ubuntu1804 run apt install python2.7 python-pip -y 
Ubuntu1804 run apt install python-numpy python-scipy  -y

write-host "Please continue with project setup by following the steps in the project readme"
# You'll need to do this manually after creating a user
# Ubuntu1804 run pip install -U scikit-learn

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
