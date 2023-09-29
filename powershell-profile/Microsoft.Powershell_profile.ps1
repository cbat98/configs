function List-AllFiles {
    param (
        [Parameter()][string]$directory="./"
    )

    eza -la $directory
}

$repos = "G:\Repos"
$configs = "$repos\configs"

$env:path = "C:\Users\charlie\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "$configs\scoop\"

Set-Alias -Name grep  -Value findstr
Set-Alias -Name sln   -Value .\*.sln
Set-Alias -Name cb    -Value Set-Clipboard
Set-Alias -Name lg    -Value lazygit
Set-Alias -Name vim   -Value nvim.exe
Set-Alias -Name zip   -Value Compress-Archive
Set-Alias -Name unzip -Value Expand-Archive
Set-Alias -Name ls    -Value eza    -Option AllScope
Set-Alias -Name ll    -Value List-AllFiles
Set-Alias -Name cat   -Value bat    -Option AllScope
  
Set-ExecutionPolicy -scope Process bypass

Import-Module -Name "Terminal-Icons"

oh-my-posh init pwsh --config "$configs\oh-my-posh\material-edit.omp.json" | Invoke-Expression
