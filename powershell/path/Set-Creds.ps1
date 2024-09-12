param (
    [Parameter(Mandatory = $true)][string]$CredentialName,
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/credentials"
)

$Credential = Get-Credential

$credFilePath = Join-Path -Path $CredentialsFolder -ChildPath $CredentialName -AdditionalChildPath ".xml"
$Credential | Export-Clixml -Path $credFilePath
