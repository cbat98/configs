<#
.SYNOPSIS
    Symlinks everything in links.tsv (windows column) into place.

.DESCRIPTION
    Safe to re-run: correct links are left alone, real files/dirs in the way
    are backed up with a .bak-<timestamp> suffix rather than overwritten.

    Creating symlinks on Windows requires either an elevated (Administrator)
    PowerShell, or Developer Mode enabled (Settings > Privacy & Security >
    For developers).

.PARAMETER Profile
    Which PowerShell profile script to link as $PROFILE: "home" (default) or
    "work". Only affects the powershell/*.ps1 entry.
#>
param(
    [ValidateSet('home', 'work')]
    [string]$Profile = 'home'
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$manifest = Join-Path $PSScriptRoot 'links.tsv'
$stamp = Get-Date -Format 'yyyyMMddHHmmss'

Get-Content $manifest | ForEach-Object {
    $line = $_.Trim()
    if (-not $line -or $line.StartsWith('#')) { return }

    $parts = $line -split "`t"
    $source, $winTarget = $parts[0], $parts[2]
    if ($winTarget -eq '-') { return }

    if ($source -eq 'powershell/home.ps1') {
        $source = "powershell/$Profile.ps1"
    }

    $src = Join-Path $repoRoot ($source -replace '/', [IO.Path]::DirectorySeparatorChar)
    $dest = [Environment]::ExpandEnvironmentVariables($winTarget)

    if (-not (Test-Path $src)) {
        Write-Warning "skip: $source (source missing)"
        return
    }

    $existing = Get-Item -Path $dest -Force -ErrorAction SilentlyContinue
    if ($existing -and $existing.LinkType -and $existing.Target -eq $src) {
        Write-Host "ok:   $dest -> $source"
        return
    }

    $destDir = Split-Path -Parent $dest
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if (Test-Path $dest) {
        Write-Host "backup: $dest -> $dest.bak-$stamp"
        Move-Item -Path $dest -Destination "$dest.bak-$stamp"
    }

    try {
        New-Item -ItemType SymbolicLink -Path $dest -Target $src -Force | Out-Null
        Write-Host "linked: $dest -> $source"
    }
    catch {
        Write-Error "Failed to link $dest -> $source. Run as Administrator or enable Developer Mode. $_"
    }
}
