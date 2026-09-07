param (
    [Parameter(Mandatory)][string]$ComputerName,
    [Parameter(Mandatory)][int32]$Port,
    [Parameter()][int32]$Timeout = 100
)

$result = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ComputerName, $Port).Wait($Timeout)

return [pscustomobject]@{
    ComputerName     = $ComputerName
    TcpTestSucceeded = $result
}
