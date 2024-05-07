param (
    [Parameter(Mandatory=$false)]
    [string]$directory=".\"
)

Invoke-Expression "fd -H -t d \.git$ $directory" | Split-Path
