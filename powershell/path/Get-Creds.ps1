param (
    [Parameter(Mandatory)][string]$CredentialName,
    [Parameter()][string]$CredentialsFolder="$env:USERPROFILE/Credentials"
)

Import-Clixml -Path (Join-Path -Path $CredentialsFolder -ChildPath "$CredentialName.creds")
