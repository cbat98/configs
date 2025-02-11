param (
    [Parameter(Mandatory)][scriptblock]$ScriptBlock
)

$moduleName = "Profiler"
if (-not (Get-Module -Name $moduleName -ListAvailable)) {
    Install-Module -Name Profiler
}

Import-Module -Name $moduleName

Trace-Script -ScriptBlock $ScriptBlock | Select-Object -ExpandProperty Top50SelfDuration | Out-GridView
