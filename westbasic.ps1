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

#Forceer Windows updates, moet eigenlijk in het image al zitten.
#Install-WindowsUpdate -acceptEula
#if (Test-PendingReboot) { Invoke-Reboot }

#--- Voeg Lokale Source Toe ---
choco source add -n=Omroep-West -s="http://packageserver.omroep.local/chocolatey"

#--- Internet Installs vanaf hier ---
choco install chocolatey -y
choco install boxstarter -y


#Applicaties van Community Repository
#choco install chocolateygui -y
#choco install filezilla -y
#choco install microsoft-edge -y
#choco install foxitreader -y
#choco install keepass -y
#choco install firefox -y
#choco install notepadplusplus -y
#choco install quicktime -y
#choco install slack -y
#choco install spotify -y
#choco install vlc -y
#choco install winrar -y
#choco install 4k-video-downloader -y
#choco install googlechrome --ignore-checksums -y
#choco install irfanview -y
#choco install irfanviewplugins -y
#choco install 7zip -y
#choco install obs -y
#choco install tightvnc -y
#choco install windirstat -y
#choco install winscp -y
#choco install gimp -y
#choco install putty -y
#choco install paint.net -y
#choco install camstudio -y
#hieronder alvast de installatie van de codecs tbv de custom GML Audacity
choco install audacity-lame -y
choco install audacity-ffmpeg -y
#hieronder de dotnet installatie die nodig is voor Exact Globe
choco install dogtail.dotnet3.5sp1 -y
choco install dotnet4.7.1 -y
#hieronder javaruntime 8 installatie voor bv Incite
choco install javaruntime -y

#--- Enable Remote Desktop en Remote Powershell, werkt alleen in boxstarter ---
Enable-RemoteDesktop -Force
Enable-PSRemoting -SkipNetorkProfileCheck -Force

#--- Company installaties
choco install vfwcodecs_20 -s "http://packageserver.omroep.local/chocolatey" -y --allow-empty-checksums
choco install adobephotoshopelements10 -s "http://packageserver.omroep.local/chocolatey" -y
choco install wacomtablet -s "http://packageserver.omroep.local/chocolatey" -y
choco install Audacity-2-2-2-211-GMLversion -s "http://packageserver.omroep.local/chocolatey" -y
choco install AstiumSwitchBoard-21-21961 -s "http://packageserver.omroep.local/chocolatey" -y
choco install AudinateDanteDVS -s "http://packageserver.omroep.local/chocolatey" -y
choco install MicrosoftOffice2019 -s "http://packageserver.omroep.local/chocolatey" -y
choco install ExactGlobeNextInstallOnly -s "http://packageserver.omroep.local/chocolatey" -y




#--- Remove Microsoft Packages ---
#Get-AppxPackage *Microsoft.549981C3F5F10* | Remove-AppxPackage

#executeScript "WindowsTemplateStudio.ps1";
#executeScript "GetUwpSamplesOffGithub.ps1";

if (Test-PendingReboot) { Invoke-Reboot }

#--- Lokale installs vanaf hier ---
#--- Rename NUC
choco install RenameNUC -s "http://packageserver.omroep.local/chocolatey" -y

if (Test-PendingReboot) { Invoke-Reboot }

#--- Domain Join ---
#activate timesync tbv AD
W32tm /resync /force
choco install DomainJoin -s "http://packageserver.omroep.local/chocolatey" -y

if (Test-PendingReboot) { Invoke-Reboot }


#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate

