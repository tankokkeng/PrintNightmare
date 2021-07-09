$computers = Get-ADComputer -Filter 'OperatingSystem -like "*Serv*"' -Properties Name,LastLogonDate | Where { $_.LastLogonDate -GT (Get-Date).AddDays(-30) }
foreach ($computer in $computers)
{
    $computer.Name | Out-File -Append C:\scripts\servers.txt
}

