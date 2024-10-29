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
        return "<missing>"
    }

    $splitted = $commits.Substring($branchStatus.Length + 1).Split(" ")

    $ahead = "0"
    $behind = "0"

    if ($splitted.Count -ge 2) {
        $ahead = [int]$splitted[0]
        $behind = [int]$splitted[1] * -1
    }

    if ($trackedEdits + $untrackedEdits + $ahead + $behind -eq 0) {
        return ""
    }

    return "↑$ahead ↓$behind ~$trackedEdits ?$untrackedEdits"
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
