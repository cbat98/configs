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
Write-Host "`nElapsed time: $elapsed"

Write-Host "Estimated completion at:  $projComplete ($([math]::Round($totalSeconds / 100, 2))s per %)"
