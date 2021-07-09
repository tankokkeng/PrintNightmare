$servers = ""
$servers=Get-Content -Path C:\scripts\servers.txt
foreach ($server in $servers) 
{

        Write-Host $server
        Resolve-DnsName -Name $server
        #Get-Service -ComputerName (Get-Content -Path C:\scripts\servers.txt) -Name Spooler

    $s = Get-PSSession
    if ($s -ne $null)
    {
        Remove-PSSession -Session $s
    }
    else
    {
        $myserver = $server    
        $s = New-PSSession -ComputerName $myserver
        Invoke-Command -Session $s { Get-Service -Name Spooler }
        Invoke-Command -Session $s { Stop-Service -Name Spooler -Force }
        Invoke-Command -Session $s { Set-Service -Name Spooler -StartupType Disabled }
        Invoke-Command -Session $s { Get-Service -Name Spooler }
        Remove-PSSession -Session $s

        Get-Service -ComputerName $myserver -Name Spooler
    }

    $servers=""   
}


