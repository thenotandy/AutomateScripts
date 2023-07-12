$tempdir = 'C:\Windows\temp'
$tempdir = $tempdir.tostring()
$appToMatch = '*Duo Authentication for Windows Logon x64*'
$msiFile = '"' + $tempdir+"\duo-win-login-4.2.2.exe" +'"'
$msiArgs = ' /S /v/qn/norestart'

function Get-InstalledApps
{
    if ([IntPtr]::Size -eq 4) {
        $regpath = 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
    }
    else {
        $regpath = @(
            'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*'
            'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*'
        )
    }
    Get-ItemProperty $regpath | .{process{if($_.DisplayName -and $_.UninstallString) { $_ } }} | Select DisplayName, Publisher, InstallDate, DisplayVersion, UninstallString |Sort DisplayName
}

$result = Get-InstalledApps | where {$_.DisplayName -like $appToMatch}
Get-InstalledApps | where {$_.DisplayName -like $appToMatch}
If ($result.DisplayVersion -lt '4.2.2.1755') {
    #(Start-Process -FilePath $msiFile -Wait -Passthru).ExitCode
    $ErrorActionPreference = 'SilentlyContinue'
    [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
    wget -uri 'https://dl.duosecurity.com/duo-win-login-latest.exe' -outfile 'C:\Windows\Temp\duo-win-login-4.2.2.exe' |Out-Null
    sleep 5
    $msiFile + $msiArgs
    (Start-Process -FilePath $msiFile -ArgumentList $msiArgs -Wait -Passthru).ExitCode

}
