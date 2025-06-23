param (
    [Parameter(Mandatory)][string]$Identity,
    [Parameter(Mandatory)][string]$Server
)

return Get-ADUser -Identity $Identity -Properties MemberOf -Server $Server |
    Select-Object -ExpandProperty MemberOf |
    Sort-Object |
    ForEach-Object -Process {
        return $_.Split(",")[0].Split("=")[1]
    }
