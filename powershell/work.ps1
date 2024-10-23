function Get-AllFilesAsList {
    Invoke-Expression -Command "eza -la"
}

function Get-AllFilesTreeDepth {
    param (
        [Parameter()][string]$depth = 2
    )

    Invoke-Expression -Command "eza -TL $depth"
}

$repos = "D:\repos"
$configs = "$repos\misc\configs"

$env:path += ";" + "$repos\microlise-pocs\techops-shared\team\charlieb\common"
$env:path += ";" + "$configs\powershell\path"

. "$repos\azdo\tfs-scripts\TFSApiHelpers.ps1"

Import-Module -Name Microsoft.WinGet.CommandNotFound

Set-Alias -Name lg -Value lazygit
Set-Alias -Name ll -Value Get-AllFilesAsList
Set-Alias -Name lt -Value Get-AllFilesTreeDepth
  
(@(& 'oh-my-posh.exe' init pwsh --config='D:\repos\misc\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression

Write-Host ""
