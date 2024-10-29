param (
    [Parameter(Mandatory)][scriptblock]$ScriptBlock
)

Install-Module -Name Profiler

Trace-Script -ScriptBlock $ScriptBlock | Select-Object -ExpandProperty Top50SelfDuration | Out-GridView
