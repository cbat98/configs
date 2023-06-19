$repos = "G:\Repos"
$configs = "$repos\configs"

$env:path = "C:\Program Files\Notepad++" + ";" + $env:path
$env:path += ";" + "$configs\powershell-profile\path"
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "C:\Program Files\Couchbase\Server\bin\"

Set-Alias grep findstr
Set-Alias sln .\*.sln
Set-Alias cb Set-Clipboard
Set-Alias lg lazygit.exe
  
Set-ExecutionPolicy -scope Process bypass

Import-Module -Name "Terminal-Icons"

# oh-my-posh init pwsh --config $configs\oh-my-posh\bubbles-edited.omp.json | Invoke-Expression
