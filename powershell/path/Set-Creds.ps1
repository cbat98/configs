param (
    [Parameter(Mandatory = $true)][string]$CredentialName,
    [Parameter()][string]$Username = "",
    [Parameter()][string]$Password = "",
    [Parameter()][string]$CredentialsFolder = "$env:USERPROFILE/credentials"
)

if (-not (Test-Path -Path $CredentialsFolder)) {
    New-Item -ItemType Directory -Path $CredentialsFolder -Force | Out-Null
}

if ($Username -and $Password) {
    $Credential = New-Object System.Management.Automation.PSCredential ($Username, (ConvertTo-SecureString -String $Password -AsPlainText -Force))
} else {
    if ($Username) {
        $Credential = Get-Credential -UserName $Username
    } else {
        $Credential = Get-Credential
    }
}

$credFilePath = Join-Path -Path $CredentialsFolder -ChildPath "$CredentialName.xml"
$Credential | Export-Clixml -Path $credFilePath
