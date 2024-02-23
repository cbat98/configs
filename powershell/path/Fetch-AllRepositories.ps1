param (
    [Parameter(Mandatory=$false)]
    [switch]$Prune,
    [Parameter(Mandatory=$false)]
    [string]$MainRepositoryFolder="$repos"
)

$errors = 0

Write-Host "Finding repositories in $MainRepositoryFolder and subfolders"

$repos = Invoke-Expression -Command "$($PSCommandPath | Split-Path -Parent)\Get-AllRepositories.ps1 $MainRepositoryFolder -ErrorAction SilentlyContinue"

Write-Host "Found $($repos.Count) repositories"

$repos | ForEach-Object -Process {
    if ($Prune) {
        Write-Host "Running 'git fetch --prune' in $_"
        Invoke-Expression -Command "git -C $_ fetch --prune"
    } else {
        Write-Host "Running 'git fetch' in $_"
        Invoke-Expression -Command "git -C $_ fetch"
    }

    $errors = if ($lastexitcode -ne 0) { $errors + 1 } else { $errors }
}

$outputString = (Get-Date -UFormat "%Y-%m-%d - %H-%M-%S").ToString() + " - fetched $($repos.Count) repositories with $errors errors"

Write-Host $outputString
