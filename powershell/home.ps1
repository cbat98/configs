function Get-AllFilesAsList {
    eza -la $directory
}

function Open-Explorer {
    explorer .
}

$repos = "d:\repos"
$configs = "$repos\configs"

$env:path = "C:\Users\charlie\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + "$configs\powershell\path"
$env:path += ";" + "$configs\scoop\"

Set-Alias -Name lg     -Value lazygit
Set-Alias -Name ls     -Value eza    -Option AllScope
Set-Alias -Name cat    -Value bat    -Option AllScope
Set-Alias -Name ll     -Value Get-AllFilesAsList
Set-Alias -Name oex    -Value Open-Explorer

(@(& 'C:/Users/Charlie/scoop/apps/oh-my-posh/current/oh-my-posh.exe' init pwsh --config='d:\repos\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression

Invoke-RestMethod -Uri https://icanhazdadjoke.com/ -Headers @{accept="text/plain"}
Write-Host ""
