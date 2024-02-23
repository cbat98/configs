param (
    [Parameter(Mandatory)][string]$FilePath,
    [Parameter(Mandatory)][string]$Username,
    [Parameter(Mandatory)][string]$ComputerName
)

$fileName = Split-Path -Path $FilePath -Leaf
$command = "scp $FilePath $Username@$ComputerName`:$fileName"

Write-Host "Running command: $command"
Invoke-Expression $command
