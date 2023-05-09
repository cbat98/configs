$repos = "G:\Repos"
$configs = "$repos\configs"

$env:path = "C:\Program Files\Notepad++" + ";" + $env:path
$env:path += ";" + "$configs\powershell-profile\path"
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
  
Set-ExecutionPolicy -scope Process bypass
  
oh-my-posh init pwsh --config $configs\oh-my-posh\bubbles-edited.omp.json | Invoke-Expression
  
Set-Alias grep findstr
Set-Alias sln .\*.sln
Set-Alias cb Set-Clipboard
