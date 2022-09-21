$pattern = "(^9\.9\.9\.11)|(^149.112.112.11)"
$string = Get-DnsServerForwarder | select -expandproperty IPAddress | select -expandproperty IPaddresstoString
$cnt = 1
foreach ($IPAddress in $string)
{
    $Internal = -join($Internal,$IPAddress | select-string  -Pattern $pattern -NotMatch) + ", "
    $cnt++
}
$Internal
