param (
    [Parameter(Mandatory=$false)]
    [string]$Directory=".\"
)

Invoke-Expression "fd -H -t d -t f \.git$ $directory" | Split-Path
