$repos = "G:\Repos"
$configs = "$repos\configs"
$tools = "D:\tools"
 
# Functions  
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();

    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
  
function Set-WindowTitle {
    $Title = ""
    
    if (Test-Administrator) {
        $Title = " - Administrator"
    }

    $host.ui.RawUI.WindowTitle = $env:computername + "-" + $PID + $Title
}
   
# Variables

$env:path = "C:\Program Files\Notepad++" + ";" + $env:path

$env:path += ";" + "$configs\powershell-profile\path"
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
  
Set-WindowTitle
   
Set-ExecutionPolicy -scope Process bypass
  
oh-my-posh init pwsh --config $configs\oh-my-posh\bubbles-edited.omp.json | Invoke-Expression
  
Set-Alias grep findstr
Set-Alias sln .\*.sln
Set-Alias cb Set-Clipboard
