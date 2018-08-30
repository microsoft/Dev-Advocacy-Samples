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
#--- Ubuntu ---
write-host "Installing Ubuntu 18.04 ..."
Invoke-WebRequest -Uri https://aka.ms/wsl-ubuntu-1804 -OutFile ~/Ubuntu.appx -UseBasicParsing
Add-AppxPackage -Path ~/Ubuntu.appx
# run the distro once and have it install locally with a blank root user
Ubuntu1804 install --root

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
