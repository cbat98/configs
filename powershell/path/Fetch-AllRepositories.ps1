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
    $status = Invoke-Expression -Command $command

    $trackedEdits = ($status | Where-Object { $_.StartsWith("1") }).Count
    $untrackedEdits = ($status | Where-Object { $_.StartsWith("?") }).Count

    $commits = [string](
        $status `
        | Where-Object { $_.StartsWith($branchStatus) -and $_.Length -gt $branchStatus.Length } `
        | Select-Object -First 1
    )

    if (-not $commits) {
        return [pscustomobject]@{
            "Path"           = $RepositoryPath
            "Ahead"          = 0
            "Behind"         = 0
            "TrackedEdits"   = 0
            "UntrackedEdits" = 0
            "Missing"        = $true
        }
    }

    $splitted = $commits.Substring($branchStatus.Length + 1).Split(" ")

    $ahead = "0"
    $behind = "0"

    if ($splitted.Count -ge 2) {
        $ahead = [int]$splitted[0]
        $behind = [int]$splitted[1] * -1
    }

    return [pscustomobject]@{
        "Path"           = $RepositoryPath
        "Ahead"          = $ahead
        "Behind"         = $behind
        "TrackedEdits"   = $trackedEdits
        "UntrackedEdits" = $untrackedEdits
        "Missing"        = $false
    }
}

function FormatGitStatus {
    param (
        [Parameter(Mandatory)][psobject]$Repo
    )

    if ($Repo.Missing) {
        return "<missing>"
    }

    if ($($Repo.trackedEdits) + $($Repo.untrackedEdits) + $($Repo.ahead) + $($Repo.behind) -eq 0) {
        return ""
    }

    return "↑$($Repo.ahead) ↓$($Repo.behind) ~$($Repo.trackedEdits) ?$($Repo.untrackedEdits)"
}

return & $PSScriptRoot\Get-AllRepositories.ps1 -Directory $MainRepositoryFolder `
| ForEach-Object -Process {
    $repo = $_

    $command = "git -C $repo rev-parse --abbrev-ref HEAD"

    return [pscustomobject]@{
        "Name"   = Split-Path -Path $repo -Leaf
        "Path"   = $repo
        "Branch" = Invoke-Expression -Command $command
    }
} | ForEach-Object -ThrottleLimit 10 -Parallel {
    $repo = $_

    $command = "git -C $($repo.Path) fetch --all"

    if ($using:Prune) {
        $command += " --prune"
    }

    Invoke-Expression -Command $command *>&1 | Out-Null

    return $repo
} | Sort-Object -Property name | ForEach-Object -Process {
    $repo = $_

    $augmentedRepo = ParseGitStatus -RepositoryPath $repo.Path
    $status = FormatGitStatus -Repo $augmentedRepo

    Add-Member -InputObject $repo -MemberType NoteProperty -Name "Status" -Value $status

    return $repo
} | Format-Table -AutoSize
