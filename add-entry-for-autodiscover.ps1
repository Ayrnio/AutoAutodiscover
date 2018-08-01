# Give local cache and hosts file DNS entries priority
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider"
    New-ItemProperty -Path $regPath -Name HostsPriority -propertyType DWORD -Value 3 -force | Out-Null
    New-ItemProperty -Path $regPath -Name LocalPriority -propertyType DWORD -Value 4 -force | Out-Null
    New-ItemProperty -Path $regPath -Name DnsPriority -propertyType DWORD -Value 5 -force | Out-Null
    New-ItemProperty -Path $regPath -Name NetbtPriority -propertyType DWORD -Value 6 -force | Out-Null
# Set domain name
    $domainName = Read-Host -Prompt "Enter The Domain Name"
# Create Hosts file entry
function setHostEntries([hashtable] $entries) {
    $hostsFile = "$env:windir\System32\drivers\etc\hosts"
    $newLines = @()
    $c = Get-Content -Path $hostsFile
    foreach ($line in $c) {
    $bits = [regex]::Split($line, "\s+")
    if ($bits.count -eq 2) {
    $match = $NULL
    ForEach($entry in $entries.GetEnumerator()) {
    if($bits[1] -eq $entry.Key) {
    $newLines += ($entry.Value + '     ' + $entry.Key)
    Write-Host Replacing HOSTS entry for $entry.Key
    $match = $entry.Key
    break
    }
    }
    if($match -eq $NULL) {
    $newLines += $line
    } else {
    $entries.Remove($match)
    }
    } else {
    $newLines += $line
    }
    }
    foreach($entry in $entries.GetEnumerator()) {
    Write-Host Adding HOSTS entry for $entry.Key
    $newLines += $entry.Value + '     ' + $entry.Key
    }
    Write-Host Saving $hostsFile
    Clear-Content $hostsFile
    foreach ($line in $newLines) {
        $line | Out-File -encoding ASCII -append $hostsFile
    }
}
$entries = @{
    "auotodiscover.$domainName" = "70.182.177.89"
};
setHostEntries($entries)
# Set domain name
Write-Host Clearing the DNS cache
Clear-DnsClientCache
# Fetch DNS client cache
Write-Host Fetching the DNS client cache
Get-DnsClientCache
# Lookup AutoDiscover resolution from the local machine
Write-Host Fetching AutoDiscover resolution info
Resolve-DnsName "auotodiscover.$domainName"
