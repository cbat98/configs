function Get-AllFilesAsList {
    Invoke-Expression -Command "eza -la"
}

function Get-AllFilesTreeDepth {
    param (
        [Parameter()][string]$depth = 2
    )

    Invoke-Expression -Command "eza -TL $depth"
}

function Start-CleanNeovim {
    Invoke-Expression -Command "nvim --clean $args"
}

$repos = "D:\repos"
$configs = "$repos\misc\configs"

$env:path += ";" + "$repos\pocs\techops-shared\team\charlieb\common"
$env:path += ";" + "$configs\powershell\path"

Set-Alias -Name lt -Value Get-AllFilesTreeDepth
Set-Alias -Name npp -Value "C:\Program Files\Notepad++\notepad++.exe"

if (Get-Command -Name "nvim") {
    Set-Alias -Name vim -Value Start-CleanNeovim
}

& 'oh-my-posh.exe' init pwsh --config="$configs\oh-my-posh\rainbow.omp.json" | Invoke-Expression

Write-Host ""
