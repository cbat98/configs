oh-my-posh init pwsh --config C:\Users\cbatten\AppData\Local\Programs\oh-my-posh\themes\bubbles-edited.omp.json | Invoke-Expression

$repos = "D:\dev\repos"
$workingFolder = "$repos\TechOps-Shared\Team\charlieb"
$configs = "$repos\configs"
 
# Functions  
function Test-Administrator
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
  
  
function setTitle {
    $Title=""
    if (Test-Administrator) {
        $Title=" - Administrator"
    }
    $host.ui.RawUI.WindowTitle = $env:computername + "-" + $PID + $Title
}
  
function whereAmI {
    $env:computername
}

function listJustNames {
    param (
        [parameter(Mandatory=$false)][string]$path=".\"
    )
	return Get-ChildItem -path $path -Force | Select-Object -Property Name
}
   
# Variables
$workingFolderPath = ";" + $workingFolder + "\Common"
$modulePath = $workingFolder + "\Modules;"
$env:path += $workingFolderPath
$env:path += ";" + (Get-Item "Env:ProgramFiles(x86)").Value + "\Git\bin"
$env:path += ";" + "c:\ffmpeg"
$env:path += ";" + "C:\msys64\mingw64\bin\"
$env:path += ";" + "C:\Program Files\GitHub CLI\"
$env:path += ";" + "C:\tools\neovim\nvim-win64\bin"
$env:path += ";" + "C:\Program Files\LLVM\bin"
$env:psmodulePath = $modulePath + $env:psmodulePath
  
  
$dateStamp = Get-Date
$fileDateStamp = $dateStamp.tostring("yyyy-MM-dd")
$fileName = $fileDateStamp + " - PS Console Output - $($env:username) - $($pid).log"
$logLocation = [environment]::getfolderpath("mydocuments") +"\PSLogs"
$fullLogFile = $logLocation + "\" + $fileName
  
###################################################
  
setTitle
   
# Import AD
#write-host "Importing Active Dirctory Module" -foreground Yellow
#import-module activedirectory
  
Set-ExecutionPolicy -scope Process bypass
  
  
# Create working location
  
if (!(test-path $workingFolder)) {
    # Create log destination if it does not exist
    New-Item -ItemType Directory -Force -Path $workingFolder
    write-host "Created $($workingFolder)" -foreground yellow
}
  
  
# Create log file
if (!(test-path $logLocation)) {
    # Create log destination if it does not exist
    New-Item -ItemType Directory -Force -Path $logLocation
    write-host "Created $($logLocation)" -foreground yellow
}
  
  
# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
  
  
# Create transcript file for reference
start-transcript -path $fullLogFile -force  -noclobber
  
#set-location $workingFolder
Set-Alias ll listJustNames
Set-Alias grep findstr
