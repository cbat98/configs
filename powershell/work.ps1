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

$repos = "D:\repos"
$configs = "$repos\misc\configs"

$env:path = "C:\Users\cbatten\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + "$repos\microlise-pocs\techops-shared\team\charlieb\common"
$env:path += ";" + "$configs\powershell\path"
$env:path += ";" + "$configs\scoop\"

Set-Alias -Name lg     -Value lazygit
Set-Alias -Name lt     -Value Get-AllFilesTreeDepth
Set-Alias -Name oex    -Value Open-Explorer
  
(@(& 'oh-my-posh.exe' init pwsh --config='D:\repos\misc\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression

Write-Host "$(Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Headers @{accept="text/plain"})`n"
Write-Host ""
