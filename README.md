# autoautodiscover
Hosts File/Registry Modification PowerShell Scripts for AutoDiscover
###How to Use###
1.      Run PowerShell ISE as admin
2.      From the PowerShell ISE menu, click on File, Open, locate the file named Add-Hosts-Entry-For-AutoDiscover.ps1 and click on it to open it
3.      On line 46 replace the existing IP with the IP of the AutoDiscover service on destination sever (you can get this with CMD by pinging the autodiscover record for the server, for example ping ar-east.exch091.serverdata.net).
4.      Click on the play icon in top menu-bar of PowerShell to run the script
5.      Create a new mail profile and open it in Outlook to allow it to download at the user end-point
6.      Once you are ready to revert back to the DNS/Local based autodiscover, open the second file Remove-Hosts-Entry-For-AutoDiscover.ps1 in PowerShell ISE
7.      Click the play icon in the PowerShell ISE menu-bar to run the script
