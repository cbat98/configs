# Shared PowerShell profile logic.
# Dot-sourced by home.ps1 / work.ps1 after they set $repos and $configs.
#
# Only terse, every-session shorthands live here. Anything with real
# parameters or that runs fine as its own process lives in path/ as a
# Verb-Noun script.

function ll { eza -la @args }

function lt {
    param (
        [Parameter()][string]$Path = "./",
        [Parameter()][int]$Depth = 2
    )

    eza -TL $Depth $Path
}

function gs { git status @args }

function g { git @args }

function gitopen {
    param (
        [Parameter()][string]$Remote = "origin",
        [Parameter()][string]$Path = "./"
    )

    $remoteUrl = (git -C $Path remote get-url $Remote) -replace "ssh://", "http://" -replace "22", "80"
    Start-Process -FilePath $remoteUrl
}

function tw { Remove-TrailingWhitespace.ps1 @args }

if (Get-Command -Name nvim -ErrorAction SilentlyContinue) {
    function vim { nvim --clean @args }
}

Set-Alias -Name npp -Value "C:\Program Files\Notepad++\notepad++.exe"

$env:path += ";" + "$configs\powershell\path"

& 'oh-my-posh.exe' init pwsh --config="$configs\oh-my-posh\rainbow.omp.json" | Invoke-Expression

Write-Host ""
