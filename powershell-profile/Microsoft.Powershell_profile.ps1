function Get-AllFilesAsList {
    param (
        [Parameter()][string]$directory="./"
    )

    eza -la $directory
}

$repos = "G:\Repos"
$configs = "$repos\configs"

$env:path = "C:\Users\charlie\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + "$configs\scoop\"

# Set-Alias -Name grep  -Value findstr
# Set-Alias -Name sln   -Value .\*.sln
# Set-Alias -Name cb    -Value Set-Clipboard
Set-Alias -Name lg    -Value lazygit
# Set-Alias -Name zip   -Value Compress-Archive
# Set-Alias -Name unzip -Value Expand-Archive
Set-Alias -Name ls    -Value eza    -Option AllScope
Set-Alias -Name ll    -Value Get-AllFilesAsList
Set-Alias -Name cat   -Value bat    -Option AllScope
  
# Set-ExecutionPolicy -scope Process bypass

# Import-Module -Name "Terminal-Icons"

# oh-my-posh init pwsh --config "$configs\oh-my-posh\material-edit.omp.json" | Invoke-Expression
(@(& 'C:/Users/Charlie/scoop/apps/oh-my-posh/current/oh-my-posh.exe' init pwsh --config='G:\Repos\configs\oh-my-posh\material-edit.omp.json' --print) -join "`n") | Invoke-Expression
