#Requires -RunAsAdministrator

$logPath = "D:\logs\$(Get-Date -Format 'dd-MM-yy')-UpdateScript.log"

if (Test-Path $logPath) {
    Remove-Item $logPath -Force -Confirm:$false
}

try {
    Start-Transcript -Path $logPath -Append

    Write-Host "Starting Windows Updates"
    if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) {
        Install-Module PSWindowsUpdate -Force
    }

    Import-Module PSWindowsUpdate -Force

    Get-WindowsUpdate
    Install-WindowsUpdate -MicrosoftUpdate -AcceptAll -Confirm:$false -AutoReboot:$false -IgnoreReboot -IgnoreRebootRequired

    Write-Host "Starting Application Updates"
    winget upgrade --all --force --accept-package-agreements --accept-source-agreements --silent --include-unknown
} finally {
    Write-Host "Script Finished"
    Stop-Transcript
}
