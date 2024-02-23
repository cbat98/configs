function Get-AllFilesAsList {
    param (
        [Parameter()][string]$directory="./"
    )

    eza -la $directory
}

function Open-Explorer {
    explorer .
}

$repos = "D:\dev\repos"
$configs = "$repos\misc\configs"

$env:path = "C:\Users\cbatten\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + "$configs\powershell-profile\path"
$env:path += ";" + "$configs\scoop\"

Set-Alias -Name lg    -Value lazygit
Set-Alias -Name ls    -Value eza    -Option AllScope
Set-Alias -Name ll    -Value Get-AllFilesAsList
Set-Alias -Name cat   -Value bat    -Option AllScope
Set-Alias -Name oex   -Value Open-Explorer
  
(@(& 'C:/Users/cbatten/scoop/apps/oh-my-posh/current/oh-my-posh.exe' init pwsh --config='D:\dev\repos\misc\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression
