function Get-AllFilesAsList {
    eza -la
}

function Get-AllFilesTreeDepth {
    param (
        [Parameter()][string]$depth = 2
    )

    Invoke-Expression -Command "eza -TL $depth"
}

function Start-Neovim {
    Invoke-Expression -Command "nvim $args"
}

$repos = "D:\repos"
$configs = "$repos\configs"

$env:path += ";" + "$configs\powershell\path"

Set-Alias -Name lg -Value lazygit
Set-Alias -Name lt -Value Get-AllFilesTreeDepth

if (Get-Command -Name "nvim") {
    Set-Alias -Name vim -Value Start-Neovim
}

& 'oh-my-posh.exe' init pwsh --config='$configs\oh-my-posh\material-edit.omp.json' | Invoke-Expression

Write-Host ""
