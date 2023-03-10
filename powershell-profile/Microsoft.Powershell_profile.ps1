$repos = "G:\Repos"
$workingFolder = "$repos\work\techops\TechOps-Shared\Team\charlieb"
$configs = "$repos\misc\configs"
$tools = "D:\tools"
 
# Functions  
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();

    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
  
function Set-Title {
    $Title = ""
    
    if (Test-Administrator) {
        $Title = " - Administrator"
    }

    $host.ui.RawUI.WindowTitle = $env:computername + "-" + $PID + $Title
}
   
# Variables
$workingFolderPath = ";" + $workingFolder + "\Common"

$modulePath = $workingFolder + "\Modules"
$env:psmodulePath = $modulePath + $env:psmodulePath

$env:path = "C:\Program Files\Notepad++" + ";" + $env:path

$env:path += $workingFolderPath
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "c:\ffmpeg"
$env:path += ";" + "C:\msys64\mingw64\bin\"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "C:\tools\neovim\nvim-win64\bin"
$env:path += ";" + "C:\Program Files\LLVM\bin"
$env:path += ";" + "C:\msys64\ucrt64\bin"
  
$dateStamp = Get-Date
$fileDateStamp = $dateStamp.ToString("yyyy-MM-dd")
$fileName = $fileDateStamp + " - PS Console Output - $($env:username) - $($pid).log"

$logLocation = [Environment]::GetFolderPath("MyDocuments") +"\PSLogs"
$fullLogFile = $logLocation + "\" + $fileName
  
#Processes 
Set-Title
   
Set-ExecutionPolicy -scope Process bypass
  
if (!(Test-Path $logLocation)) {
    New-Item -ItemType Directory -Force -Path $logLocation
    Write-Host "Created $($logLocation)" -foreground yellow
}
  
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module -Name "$ChocolateyProfile"
}

oh-my-posh init pwsh --config $configs\oh-my-posh\bubbles-edited.omp.json | Invoke-Expression
  
Set-Alias grep findstr
Set-Alias sln .\*.sln

Start-Transcript -Path $fullLogFile -Force  -NoClobber
