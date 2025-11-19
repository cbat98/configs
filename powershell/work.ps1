function Get-AllFilesAsList {
    Invoke-Expression -Command "eza -la"
}

function Get-AllFilesTreeDepth {
    param (
        [Parameter()][string]$Path = "./",
        [Parameter()][string]$Depth = 2
    )

    Invoke-Expression -Command "eza -TL $depth $Path"
}

function Open-GitRemoteRepo {
    param (
        [Parameter()][string]$Remote = "origin",
        [Parameter()][string]$Path = "./"
    )

    $remoteUrl = (git -C $path remote get-url $Remote) -replace "ssh://", "http://" -replace "22", "80"
    Start-Process -FilePath $remoteUrl
}

function Git-Status {
    Invoke-Expression -Command "git status"
}

function Git-Wrapper {
    param (
        [Parameter()][string]$Command
    )

    Invoke-Expression -Command "git $Command"
 }

function Start-CleanNeovim {
    Invoke-Expression -Command "nvim --clean $args"
}

$repos = "D:\repos"
$configs = "$repos\misc\configs"

$env:path += ";" + "$repos\pocs\techops-shared\team\charlieb\common"
$env:path += ";" + "$configs\powershell\path"

Set-Alias -Name lt -Value Get-AllFilesTreeDepth
Set-Alias -Name npp -Value "C:\Program Files\Notepad++\notepad++.exe"
Set-Alias -Name gitopen -Value Open-GitRemoteRepo
Set-Alias -Name gs -Value Git-Status
Set-Alias -Name g -Value Git-Wrapper

if (Get-Command -Name "nvim") {
    Set-Alias -Name vim -Value Start-CleanNeovim
}

& 'oh-my-posh.exe' init pwsh --config="$configs\oh-my-posh\rainbow.omp.json" | Invoke-Expression

Write-Host ""
