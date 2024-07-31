param (
    [Parameter(Mandatory=$false)]
    [switch]$Prune,
    [Parameter(Mandatory=$false)]
    [string]$MainRepositoryFolder="$repos"
)

Write-Host "Finding repositories in $MainRepositoryFolder and subfolders"

$repos = Invoke-Expression -Command "$($PSCommandPath | Split-Path -Parent)\Get-AllRepositories.ps1 $MainRepositoryFolder -ErrorAction SilentlyContinue"

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
    $command = "git -C $_ $($gitArguments -join " ")"

    $output = Invoke-Expression -Command $command
    if ($null -ne $output -and $output -ne "") {
        Write-Host -ForegroundColor Yellow -Object "[$(Split-Path -Path $_ -Leaf)]"
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
