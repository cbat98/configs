param (
    [Parameter()][string]$CredentialName,
    [Parameter()][switch]$Copy,
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/credentials"
)

if (-not (Test-Path -Path $CredentialsFolder)) {
    throw "Path: $CredentialsFolder does not exist"
}

if (-not $CredentialName) {
    return Get-ChildItem -Path $CredentialsFolder
}

$credential = Import-Clixml -Path (Join-Path -Path $CredentialsFolder -ChildPath "$CredentialName.xml")

if ($Copy) {
    $credential.GetNetworkCredential().Password | Set-Clipboard
}

return $credential
