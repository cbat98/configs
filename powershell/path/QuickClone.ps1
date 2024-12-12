param (
    [Parameter(Mandatory)][string]$RepoUrl,
    [Parameter()][string]$SourceFolder = "$env:USERPROFILE\Downloads"
)

$repoName = $RepoUrl.Split("/")[-1].Split(".git")[0]
$repoPath = Join-Path -Path $SourceFolder -ChildPath (Get-Random)

Write-Host "Repo: $repoName"

Write-Host "`nSpawning new PowerShell session"

Write-Host "Type " -NoNewline
Write-Host "``exit``" -ForegroundColor Red -NoNewline
Write-Host " to leave"

$cmd = "pwsh -NoExit -Command `"git -C $SourceFolder clone $RepoUrl $repoPath; Set-Location -Path $repoPath`""
Invoke-Expression $cmd

Remove-Item -Path $repoPath -Recurse -Force
Write-Host "Session closed - local repo deleted"
