# Description: Boxstarter Script
# Author: Microsoft
# Common settings for West desktop app development

Disable-UAC

# Boxstarter options
$Boxstarter.RebootOk=$true # Allow reboots?
$Boxstarter.NoPassword=$false # Is this a machine with no login password?
$Boxstarter.AutoLogin=$true # Save my password securely and auto-login after a reboot

# Get the base URI path from the ScriptToCall value
$bstrappackage = "-bootstrapPackage"
$helperUri = $Boxstarter['ScriptToCall']
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
#executeScript "SystemConfiguration.ps1";
#executeScript "FileExplorerSettings.ps1";
#executeScript "RemoveDefaultApps.ps1";
#executeScript "CommonDevTools.ps1";

#--- Tools ---
#--- Installing VS and VS Code with Git
# See this for install args: https://chocolatey.org/packages/VisualStudio2017Community
# https://docs.microsoft.com/en-us/visualstudio/install/workload-component-id-vs-community
# https://docs.microsoft.com/en-us/visualstudio/install/use-command-line-parameters-to-install-visual-studio#list-of-workload-ids-and-component-ids
# visualstudio2017community
# visualstudio2017professional
# visualstudio2017enterprise

#choco install -y visualstudio2017community --package-parameters="'--add Microsoft.VisualStudio.Component.Git'"
#Update-SessionEnvironment #refreshing env due to Git install

Install-WindowsUpdate -acceptEula
if (Test-PendingReboot) { Invoke-Reboot }

#--- Voeg Lokale Source Toe ---
choco source add -n=Omroep-West -s="http://packageserver.omroep.local/chocolatey"

#--- Internet Installs vanaf hier ---
choco install chocolatey -y
choco install boxstarter -y
choco install filezilla -y
choco install notepadplusplus -y
choco install microsoft-edge -y
choco install irfanview -y
choco install chocolateygui -y
choco install googlechrome -y
choco install firefox -y

#--- Enable Remote Desktop en Remote Powershell, werkt alleen in boxstarter ---
Enable-RemoteDesktop -Force
Enable-PSRemoting -Force

#--- Remove Microsoft Packages ---
#Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage

#executeScript "WindowsTemplateStudio.ps1";
#executeScript "GetUwpSamplesOffGithub.ps1";

if (Test-PendingReboot) { Invoke-Reboot }

#--- Lokale installs vanaf hier ---
#--- Rename NUC
choco install RenameNUC -s "http://packageserver.omroep.local/chocolatey" -force

if (Test-PendingReboot) { Invoke-Reboot }

#--- Domain Join ---
#activate timesync tbv AD
W32tm /resync /force
choco install DomainJoin -s "http://packageserver.omroep.local/chocolatey" -force

if (Test-PendingReboot) { Invoke-Reboot }


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate

