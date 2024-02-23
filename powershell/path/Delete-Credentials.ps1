param (
    [Parameter(Mandatory)][string]$StartsWith
)

$creds = cmdkey.exe /l `
    | convertfrom-csv `
    | Select-Object -ExpandProperty "Currently stored credentials:" `
    | Where-Object { $_.StartsWith("Target") } `
    | % { $_.Replace("Target: LegacyGeneric:target=", "") } `
    | Where-Object { $_.StartsWith($StartsWith) } `
    | ForEach-Object { Invoke-Expression -Command "cmdkey.exe /delete `"$_`"" | Write-Host }
