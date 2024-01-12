param (
    [Parameter(Mandatory=$false)]
    [string]$directory=".\"
)

Invoke-Expression "fd -H -I -t d \.git$ $directory" | Split-Path
