# Restore default DNS entries priority in registry
    $regPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\ServiceProvider"
    New-ItemProperty -Path $regPath -Name HostsPriority -propertyType DWORD -Value 500 -force | Out-Null
    New-ItemProperty -Path $regPath -Name LocalPriority -propertyType DWORD -Value 499 -force | Out-Null
    New-ItemProperty -Path $regPath -Name DnsPriority -propertyType DWORD -Value 2000 -force | Out-Null
    New-ItemProperty -Path $regPath -Name NetbtPriority -propertyType DWORD -Value 2001 -force | Out-Null

# Remove hosts file entries
$i = 0
$length = get-content $env:windir\System32\drivers\etc\hosts | Measure-Object -Line
$op = get-content C:\Windows\system32\drivers\etc\hosts | Select-Object -first ($length.lines-2)
write-output $op | out-file -Encoding UTF8 C:\Windows\system32\drivers\etc\hosts
# Clear the DNS cache
Write-Host Clearing the DNS cache
Clear-DnsClientCache
# Fetch DNS client cache
Write-Host Fetching the DNS client cache
Get-DnsClientCache
