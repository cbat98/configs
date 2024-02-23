. $PSScriptRoot\buckets.ps1
. $PSScriptRoot\apps.ps1

$manifestFileName = "manifest.json"
$manifestPath = Join-Path -Path $PSScriptRoot -ChildPath $manifestFileName
$manifest = Get-Content -Path $manifestPath | ConvertFrom-Json

$hostname = $env:COMPUTERNAME
$commonManifest = $manifest.hosts.common
$hostManifest = $manifest.hosts | Select-Object -ExpandProperty $hostname

$targetBuckets = ($commonManifest.buckets + $hostManifest.buckets) | Sort-Object -Unique
$targetApps = ($commonManifest.apps + $hostManifest.apps) | Sort-Object -Unique

Write-Host "--ScoopSync--"

Write-Host ""
scoop update

Sync-Buckets -TargetBuckets $targetBuckets
Sync-Apps -TargetApps $targetApps

Write-Host "`nUpdating all apps"
scoop update *

Write-Host "`nCleaning up"
scoop cleanup *
