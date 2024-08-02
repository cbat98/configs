param (
    [Parameter(Mandatory=$false)]
    [switch]$Prune,
    [Parameter(Mandatory=$false)]
    [string]$MainRepositoryFolder="$repos"
)

Write-Host "Finding repositories in $MainRepositoryFolder and subfolders"

$repos = Invoke-Expression -Command "$PSScriptRoot\Get-AllRepositories.ps1 $MainRepositoryFolder -ErrorAction SilentlyContinue" `
| Sort-Object -Property @{Expression = { Split-Path -Path $_ -Leaf }}

Write-Host "Found $($repos.Count) repositories:"
foreach ($repo in $repos) {
    Write-Host "  $(Split-Path -Path $repo -Leaf)"
}
Write-Host

$gitArguments = @(
    "fetch",
    "--all"
)

if ($Prune) {
    $gitArguments += "--prune"
}

$errors = $repos | ForEach-Object -Process {
    Write-Host -ForegroundColor Yellow -Object "[$(Split-Path -Path $_ -Leaf)]"

    $command = "git -C $_ $($gitArguments -join " ")"
    $output = Invoke-Expression -Command $command

    if ($null -ne $output -and $output -ne "") {
        Out-String -InputObject $output | Write-Host
    }

    if ($lastexitcode -ne 0) {
        return 1
    }

    return 0
} `
| Measure-Object -Sum `
| Select-Object -ExpandProperty Sum

$outputString = (Get-Date -UFormat "%Y-%m-%d - %H-%M-%S").ToString() + " - fetched $($repos.Count) repositories with $errors errors"

Write-Host $outputString
