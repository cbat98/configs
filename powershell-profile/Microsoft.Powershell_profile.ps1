$repos = "D:\dev\repos"
$workingFolder = "$repos\TechOps-Shared\Team\charlieb"
$configs = "$repos\configs"
 
# Functions  
function Test-Administrator {
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();

    return (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
  
function setTitle {
    $Title = ""
    
    if (Test-Administrator) {
        $Title = " - Administrator"
    }

    $host.ui.RawUI.WindowTitle = $env:computername + "-" + $PID + $Title
}
  
function listJustNames {
    param (
        [Parameter(Mandatory=$false)][string]$path=".\"
    )

	return Get-ChildItem -path $path -Force | Select-Object -Property Name
}
   
# Variables
$workingFolderPath = ";" + $workingFolder + "\Common"

$modulePath = $workingFolder + "\Modules;"
$env:psmodulePath = $modulePath + $env:psmodulePath

$env:path += $workingFolderPath
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "c:\ffmpeg"
$env:path += ";" + "C:\msys64\mingw64\bin\"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "C:\tools\neovim\nvim-win64\bin"
$env:path += ";" + "C:\Program Files\LLVM\bin"
  
$dateStamp = Get-Date
$fileDateStamp = $dateStamp.tostring("yyyy-MM-dd")
$fileName = $fileDateStamp + " - PS Console Output - $($env:username) - $($pid).log"

$logLocation = [environment]::getfolderpath("mydocuments") +"\PSLogs"
$fullLogFile = $logLocation + "\" + $fileName
  
#Processes 
setTitle
   
Set-ExecutionPolicy -scope Process bypass
  
if (!(test-path $logLocation)) {
    New-Item -ItemType Directory -Force -Path $logLocation
    Write-Host "Created $($logLocation)" -foreground yellow
}
  
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

oh-my-posh init pwsh --config C:\Users\cbatten\AppData\Local\Programs\oh-my-posh\themes\bubbles-edited.omp.json | Invoke-Expression
  
Set-Alias ll listJustNames
Set-Alias grep findstr

Start-Transcript -Path $fullLogFile -Force  -NoClobber
