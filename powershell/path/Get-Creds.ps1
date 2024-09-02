param (
    [Parameter()][string]$CredentialName,
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/Credentials",
    [Parameter()][switch]$Copy
)

if (-not $CredentialName) {
    return Get-ChildItem -Path $CredentialsFolder
}

$credential = Import-Clixml -Path (Join-Path -Path $CredentialsFolder -ChildPath "$CredentialName.creds")

if ($Copy) {
    $credential.GetNetworkCredential().Password | Set-Clipboard
}

return $credential
