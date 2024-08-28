param (
    [Parameter(Mandatory)][string]$CredentialName,
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/Credentials",
    [Parameter()][switch]$Copy
)

$credential = Import-Clixml -Path (Join-Path -Path $CredentialsFolder -ChildPath "$CredentialName.creds")

if ($Copy) {
    $credential.GetNetworkCredential().Password | Set-Clipboard
}

return $credential
