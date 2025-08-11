param (
    [Parameter(Mandatory, HelpMessage = "The time that the 'job' started at in yy-MM-dd HH:mm:ss format")]
    [string]$startedAt,
    [Parameter(Mandatory, HelpMessage = "How far through the 'job' is as a percentage (0 to 1)")]
    [double]$percentZeroOne
)

$startDateTime = [datetime]::parseexact($startedAt, 'yy-MM-dd HH:mm:ss', $null)
$nowDateTime = Get-Date

$elapsed = $nowDateTime - $startDateTime

$totalSeconds = $elapsed.TotalSeconds / $percentZeroOne

$secondsLeft = $totalSeconds - $elapsed.TotalSeconds
$projComplete = (Get-Date).AddSeconds($secondsLeft).ToString("yy-MM-dd HH:mm:ss")

Write-Host "Completed: $([math]::Round($percentZeroOne * 100, 2))%"
Write-Host "Elapsed time: $elapsed"

Write-Host "`nEstimated remaining time: $([TimeSpan]::FromSeconds($secondsLeft))"
Write-Host "Estimated completion at:  $projComplete"

Write-Host "`nSpeed: $([math]::Round($totalSeconds / 100, 2))s per %"
Write-Host "       $([math]::Round($percentZeroOne / $elapsed.TotalSeconds * 100, 2))% per second"
