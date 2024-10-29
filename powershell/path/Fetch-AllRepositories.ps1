param (
    [Parameter(Mandatory = $false)]
    [switch]$Prune,
    [Parameter(Mandatory = $false)]
    [string]$MainRepositoryFolder = "$repos"
)

function ParseGitStatus {
    param (
        [Parameter(Mandatory)][string]$RepositoryPath
    )

    $branchStatus = "# branch.ab"

    $command = "git -C $RepositoryPath status --branch --porcelain=2"
    $line = [string](
        Invoke-Expression -Command $command `
        | Where-Object { $_.StartsWith($branchStatus) -and $_.Length -gt $branchStatus.Length } `
        | Select-Object -First 1
    )

    $splitted = $line.Substring($branchStatus.Length + 1).Split(" ")

    $ahead = "+0"
    $behind = "-0"

    if ($splitted.Count -ge 2) {
        $ahead = $splitted[0]
        $behind = $splitted[1]
    }

    return "$ahead $behind"
}

$repos = & $PSScriptRoot\Get-AllRepositories.ps1 -Directory $MainRepositoryFolder `
| ForEach-Object -Process {
    $repo = $_

    $command = "git -C $repo rev-parse --abbrev-ref HEAD"

    return [pscustomobject]@{
        "Name"   = Split-Path -Path $repo -Leaf
        "Path"   = $repo
        "Branch" = Invoke-Expression -Command $command
    }
} | Sort-Object -Property Name `
| ForEach-Object -Process {
    $repo = $_
    $command = "git -C $($repo.Path) fetch --all"

    if ($Prune) {
        $command += " --prune"
    }

    Invoke-Expression -Command $command | Out-Null

    $status = ParseGitStatus -RepositoryPath $repo.Path

    Add-Member -InputObject $repo -MemberType NoteProperty -Name "Status" -Value $status

    return $repo
}
