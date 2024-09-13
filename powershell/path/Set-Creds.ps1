param (
    [Parameter(Mandatory = $true)][string]$CredentialName,
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/credentials"
)

if (-not (Test-Path -Path $CredentialsFolder)) {
    New-Item -ItemType Directory -Path $CredentialsFolder -Force | Out-Null
}

$Credential = Get-Credential

$credFilePath = Join-Path -Path $CredentialsFolder -ChildPath $CredentialName -AdditionalChildPath ".xml"
$Credential | Export-Clixml -Path $credFilePath
