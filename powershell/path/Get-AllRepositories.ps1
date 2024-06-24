param (
    [Parameter(Mandatory=$false)]
    [string]$directory=".\"
)

Invoke-Expression "fd -H -t d -t f \.git$ $directory" | Split-Path
