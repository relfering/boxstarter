# Description: Incite Boxstarter Script
# Author: Ronald Elfering

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

#--- Voeg Lokale Source Toe ---
choco source add -n=Omroep-West -s="http://packageserver.omroep.local/chocolatey"

#--- Internet Installs vanaf hier ---
choco install chocolatey -y
choco install boxstarter -y

#Applicaties van Community Repository
choco install chocolateygui -y
#hieronder javaruntime 8 en vcredist2010 installatie voor bv Incite
#ff Ivan vragen over 32b of 64b versie
choco install javaruntime -y
choco install vcredist2010

#--- Enable Remote Desktop en Remote Powershell, werkt alleen in boxstarter ---
Enable-RemoteDesktop -Force
Enable-PSRemoting -SkipNetworkProfileCheck -Force

#--- Company installaties ---
#Zet NLD en Keyboard op Verenigde staten voor vfwcodecs.
Set-WinUserLanguageList -LanguageList nl-NL -Force
choco install vfwcodecs_20 -s "http://packageserver.omroep.local/chocolatey" -y --allow-empty-checksums
choco install ImcInciteInscriber -s "http://packageserver.omroep.local/chocolatey" -y --allow-empty-checksums 





#--- reenabling critial items ---
Enable-UAC
Enable-MicrosoftUpdate

