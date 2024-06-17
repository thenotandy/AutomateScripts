$computers = Get-ADComputer -Filter * -Properties lastLogonTimestamp
$computerLogons = @()
    
foreach ($computer in $computers) {
    if ($computer.lastLogonTimestamp -ne $null) {
        $lastLogon = [DateTime]::FromFileTime($computer.lastLogonTimestamp)
        $ninetyDaysAgo = (Get-Date).AddDays(-90)
    
        if ($lastLogon -lt $ninetyDaysAgo) {
            $computerLogons += [PSCustomObject]@{
                ComputerName = $computer.Name
                LastLogon    = $lastLogon
            }
        }
    }
}
    
$computerLogons | Format-Table -AutoSize
