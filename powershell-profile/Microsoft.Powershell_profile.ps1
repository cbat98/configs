$repos = "G:\Repos"
$configs = "$repos\configs"

$env:path = "C:\Users\charlie\scoop\apps\notepadplusplus\current" + ";" + $env:path
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "$configs\scoop\"

Set-Alias grep findstr
Set-Alias sln .\*.sln
Set-Alias cb Set-Clipboard
Set-Alias lg lazygit
Set-Alias vim nvim.exe
Set-Alias zip Compress-Archive
Set-Alias unzip Expand-Archive
Set-Alias ls eza -Option AllScope
Set-Alias cat bat -Option AllScope
  
Set-ExecutionPolicy -scope Process bypass

Import-Module -Name "Terminal-Icons"

oh-my-posh init pwsh --config $configs\oh-my-posh\bubbles-edited.omp.json | Invoke-Expression
