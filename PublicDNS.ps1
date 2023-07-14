$interfaceID = (Get-NetIPConfiguration).NetProfile.InstanceID
$interfaceKeyPath = "HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\$interfaceID"
$pattern = "(^10\.)|(^172\.1[6-9]\.)|(^172\.2[0-9]\.)|(^172\.3[0-1]\.)|(^192\.168\.)|(^127\.0\.0\.)"
$string = Get-ItemProperty -Path $interfaceKeyPath -Name 'NameServer' | select  -ExpandProperty NameServer 
$cnt = 1
foreach ($detailexplain in $string.Split(","))
{
    $Internal = -join($Internal,$detailexplain | select-string  -Pattern $pattern -NotMatch) + ", "
    $cnt++
}
$Internal
