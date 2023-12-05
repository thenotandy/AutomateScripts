Remove-Item -Path HKCU:\Software\Microsoft\Office\16.0\Outlook\Autodiscover -Recurse -Force
New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Autodiscover"
New-Item "HKCU:\Software\Microsoft\Office\16.0\Outlook\Autodiscover\RedirectServers"
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\RedirectServers' -Name  'autodiscover-s.outlook.com' -PropertyType Binary –Force
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\RedirectServers' -Name  'autodiscover-s.partner.outlook.cn' -PropertyType Binary –Force
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\RedirectServers' -Name  'autodiscover-s.outlook.de' -PropertyType Binary –Force
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\RedirectServers' -Name  'autodiscover-s.office365.us' -PropertyType Binary –Force
New-ItemProperty -Path 'HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover\RedirectServers' -Name  'autodiscover.hotmail.com' -PropertyType Binary –Force

$Name = $env:USERNAME
$Domain = $env:USERDOMAIN + ".com"
$domainlower = $Domain.ToLower()
$NewProfileName = $Name + "365"

$registryPath = "HKCU:\Software\Microsoft\Office\16.0\Outlook\AutoDiscover"
$Name = "ZeroConfigExchangeOnce"
$value = "1"
IF(!(Test-Path $registryPath))
  {New-Item -Path $registryPath -Force | Out-Null
   New-ItemProperty -Path $registryPath -Name $name -Value $value `
   -PropertyType DWORD -Force | Out-Null}
ELSE 
  {New-ItemProperty -Path $registryPath -Name $name -Value $value -PropertyType DWORD -Force | Out-Null}

$Name2 = "ExcludeLastKnownGoodUrl"
$value2 = "1"
IF(!(Test-Path $registryPath))
  {New-Item -Path $registryPath -Force  Out-Null
   New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -PropertyType DWORD -Force | Out-Null}
ELSE 
  {New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -PropertyType DWORD -Force | Out-Null}

$Name3 = "ExcludeHttpsRootDomain"
$value3 = "1"
IF(!(Test-Path $registryPath))
  {New-Item -Path $registryPath -Force  Out-Null
   New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -PropertyType DWORD -Force | Out-Null}
ELSE 
  {New-ItemProperty -Path $registryPath -Name $name2 -Value $value2 -PropertyType DWORD -Force | Out-Null}

$registryPath2 = "HKCU:\Software\Microsoft\Office\16.0\Outlook\"
$Name = "DefaultProfile"
$value = $NewProfileName
IF(!(Test-Path $registryPath2))
  {New-Item -Path $registryPath2 -Force | Out-Null
   New-ItemProperty -Path $registryPath2 -Name $name -Value $value `
   -PropertyType DWORD -Force | Out-Null}
ELSE 
  {Set-ItemProperty -Path $registryPath2 -Name $name -Value $value -Force | Out-Null}

$registryPath3 = "HKCU:\Software\Microsoft\Office\16.0\Outlook\Profiles"
$Name = $NewProfileName
New-Item -Path $registryPath3 -Name $name -Value $value -Force | Out-Null

ipconfig /flushdns
