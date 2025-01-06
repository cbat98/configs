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

$env:path += ";" + "$repos\pocs\techops-shared\team\charlieb\common"
$env:path += ";" + "$configs\powershell\path"

Set-Alias -Name ll -Value Get-AllFilesAsList
Set-Alias -Name lt -Value Get-AllFilesTreeDepth

& 'oh-my-posh.exe' init pwsh --config='D:\repos\misc\configs\oh-my-posh\material-edit.omp.json' | Invoke-Expression

Write-Host ""
