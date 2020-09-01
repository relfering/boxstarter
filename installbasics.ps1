# Basis script voor Boxstarter
# 1 sept 2020
# Ronald Elfering

#--- Inschakelen Tijdelijke Instellingen ---
Disable-UAC
Disable-MicrosoftUpdate

#--- Enable Remote Desktop en Remote Powershell, werkt alleen in boxstarter ---
Enable-RemoteDesktop -Force
Enable-PSRemoting -Force

#--- Voeg Lokale Source Toe ---
#choco source add -n=Omroep-West -s="https://chocolatey.omroepwest.nl/chocolatey"

#--- Installaleer Generieke Software ---
choco install chocolateygui -y
choco install filezilla -y

#--- Installeer Bedrijfs Software ---
#Eerst Excel / Office daarna Exact pas. Advies van Vanessa

#--- Terugzetten Tijdelijke Instellingen ---
Enable-UAC
Enable-MicrosoftUpdate
Install-WindowsUpdate -acceptEula
