# boxstarter
Boxstarter scripts voor deployment

Zet Wifi op private.
Wacht even totdat alle initieele drivers zijn geinstalleerd door Windows na een nul start.
Werkt alleen in de oude Edge en Internet Explorer zonder oneclick installers. Is eigenlijk triple click.

http://boxstarter.org/package/url?https://raw.githubusercontent.com/relfering/boxstarter/master/westbasic.ps1

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/relfering/boxstarter/master/install.txt -DisableReboots

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/relfering/boxstarter/master/install.txt?token=AOQODCP72M427Y3NHI4EINK7CBGVA -DisableReboots
