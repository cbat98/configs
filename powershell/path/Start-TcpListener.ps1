param (
    [Parameter(Mandatory)][int32]$Port
)

Write-Host "Creating listener on TCP/$Port.."
Write-Host "Ctrl+C to stop"
[System.Net.Sockets.TcpListener]::new($Port).Start(); while ($true) { Start-Sleep -Seconds 1 }
