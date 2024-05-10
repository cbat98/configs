param (
    [Parameter(Mandatory)][string]$ApiKey,
    [Parameter(Mandatory)][string]$Domain,
    [Parameter(Mandatory)][string]$ARecord,
    [Parameter(Mandatory)][string]$NewIP
)

$ErrorActionPreference = "Stop"

# build headers
$headers = @{
    "X-Auth-Key" = "Authorization"
    "Authorization" = "Bearer $ApiKey"
}

# get zone id from domain
$url = "https://api.cloudflare.com/client/v4/zones"
$response = Invoke-RestMethod -Method get -Uri $url -Headers $headers
$zoneId = $response.result | Where-Object { $_.Name -eq $Domain } | Select-Object -ExpandProperty id

# get dns record id from zone + name
$url = "https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records" -replace "{zone_id}", $zoneId
$response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers
$dnsRecordId = $response.result | Where-Object { $_.Type -eq "A" -and $_.name -eq "$ARecord.$Domain"} | Select-Object -ExpandProperty id

$url = "https://api.cloudflare.com/client/v4/zones/{zone_id}/dns_records/{dns_record_id}" -replace "{zone_id}", $zoneId -replace "{dns_record_id}", $dnsRecordId
$response = Invoke-RestMethod -Method Get -Uri $url -Headers $headers
$dnsEntry = $response.result

$dnsEntry.content = $NewIP

$response = Invoke-RestMethod -Method Put -Uri $url -Headers $headers -Body ($dnsEntry | ConvertTo-Json) -ContentType "application/json"

if (-not $response.success) {
    Write-Error $response
}
