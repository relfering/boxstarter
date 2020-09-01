# boxstarter
Boxstarter scripts voor deployment.

Zet Wifi op private.

Wacht even totdat alle initieele drivers zijn geinstalleerd door Windows na een nul start.

Werkt alleen in de oude Edge en Internet Explorer zonder oneclick installers. Is eigenlijk triple click.

Toch via Edge Chromium doen...zet dan edge://flags/#edge-click-once aan.

http://boxstarter.org/package/url?https://raw.githubusercontent.com/relfering/boxstarter/master/westbasic.ps1

Of met de noreboot optie aka /nr

http://boxstarter.org/package/nr/url?https://raw.githubusercontent.com/relfering/boxstarter/master/westbasic.ps1

Alternatieve opties via Boxstarter shell:
Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/relfering/boxstarter/master/install.txt -DisableReboots

Install-BoxstarterPackage -PackageName https://raw.githubusercontent.com/relfering/boxstarter/master/install.txt?token=AOQODCP72M427Y3NHI4EINK7CBGVA -DisableReboots
