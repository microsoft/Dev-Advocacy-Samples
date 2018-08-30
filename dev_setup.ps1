# Description: Boxstarter Script
# Author: Microsoft
# Common dev settings for machine learning using Windows and Linux native tools

Disable-UAC

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$Boxstarter | Foreach-Object { write-host "The key name is $_.Key and value is $_.Value"  }
$helperUri = $Boxstarter['ScriptToCall']
write-host "ScriptToCall is $helperUri"
$strpos = $helperUri.IndexOf($bstrappackage)
$helperUri = $helperUri.Substring($strpos + $bstrappackage.Length)
$helperUri = $helperUri.TrimStart("'", " ")
$helperUri = $helperUri.TrimEnd("'", " ")
$helperUri = $helperUri.Substring(0, $helperUri.LastIndexOf("/"))
$helperUri += "/scripts"
write-host "helper script base URI is $helperUri"

function executeScript {
    Param ([string]$script)
    write-host "executing $helperUri/$script ..."
	iex ((new-object net.webclient).DownloadString("$helperUri/$script"))
}

#--- Setting up Windows ---

#--- Enable developer mode on the system ---
# Set-ItemProperty -Path HKLM:\Software\Microsoft\Windows\CurrentVersion\AppModelUnlock -Name AllowDevelopmentWithoutDevLicense -Value 1
choco install -y vscode
Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux
#--- Ubuntu ---
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
Ubuntu1804 run apt install python3 python-pip -y 
Ubuntu1804 run apt install python-numpy python-scipy pandas -y
Ubuntu1804 run pip install -U scikit-learn
## Node tools
Ubuntu1804 run touch ~/.bashrc
Ubuntu1804 run curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.6/install.sh | bash
# Restart needed?
Ubuntu1804 run nvm install node
write-host "Finished installing tools inside the WSL distro"

Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula