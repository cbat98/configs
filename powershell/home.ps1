function Get-AllFilesAsList {
    eza -la
}

function Get-AllFilesTreeDepth {
    param (
        [Parameter()][string]$depth=2
    )

    Invoke-Expression -Command "eza -TL $depth"
}

function Open-Explorer {
    explorer .
}

$repos = "d:\repos"
$configs = "$repos\configs"

$env:path += ";" + "$configs\powershell\path"

Set-Alias -Name lg     -Value lazygit
Set-Alias -Name lt     -Value Get-AllFilesTreeDepth
Set-Alias -Name oex    -Value Open-Explorer

(@(& 'oh-my-posh.exe' init pwsh --config='d:\repos\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression
