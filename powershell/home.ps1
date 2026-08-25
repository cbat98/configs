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

    $remoteUrl = (git -C $path remote get-url $Remote) -replace "ssh://","http://" -replace "22","80"
    Start-Process -FilePath $remoteUrl
}

function Git-Status {
    Invoke-Expression -Command "git status"
}

function Start-CleanNeovim {
    Invoke-Expression -Command "nvim --clean $args"
}

function Remove-TrailingWhitespace {
    param (
        [Parameter()][string]$Path = "."
    )

    Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.FullName -notmatch '\\\.git\\' } | ForEach-Object {
        $file = $_.FullName
        $content = Get-Content $file
        if ($null -ne $content) {
            $trimmed = $content | ForEach-Object { $_.TrimEnd(" `t") }
            # Only write if there's a difference
            if (-not ($content -join "`n" -ceq ($trimmed -join "`n"))) {
                $trimmed | Set-Content $file
            }
        }
    }
}

function Git-Wrapper {
    param (
        [Parameter()][string]$Command
    )

    Invoke-Expression -Command "git $Command"
 }

function ListenOn {
    param (
        [Parameter()][int32]$PortNum
    )
    Write-Host "Creating listener on TCP/$PortNum.."
    Write-Host "Ctrl+C to stop"
    [System.Net.Sockets.TcpListener]::new($PortNum).Start(); while ($true) { Start-Sleep -Seconds 1 }
}

function Quick-TNC {
    param (
        [Parameter()][string]$ComputerName,
        [Parameter()][int32]$Port,
        [Parameter()][int32]$Timeout = 100
    )

    $result = (New-Object System.Net.Sockets.TcpClient).ConnectAsync($ComputerName, $Port).Wait($Timeout)

    return [pscustomobject]@{
        ComputerName = $ComputerName
        TcpTestSucceeded = $result
    }
}

$repos = "D:\repos"
$configs = "$repos\configs"

$env:path += ";" + "$configs\powershell\path"


Set-Alias -Name lt -Value Get-AllFilesTreeDepth
Set-Alias -Name npp -Value "C:\Program Files\Notepad++\notepad++.exe"
Set-Alias -Name gitopen -Value Open-GitRemoteRepo
Set-Alias -Name gs -Value Git-Status
Set-Alias -Name g -Value Git-Wrapper
Set-Alias -Name tw -Value Remove-TrailingWhitespace

if (Get-Command -Name "nvim") {
    Set-Alias -Name vim -Value Start-CleanNeovim
}

& 'oh-my-posh.exe' init pwsh --config="$configs\oh-my-posh\rainbow.omp.json" | Invoke-Expression

Write-Host ""
