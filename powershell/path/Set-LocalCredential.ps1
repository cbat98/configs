param (
    [Parameter(Mandatory=$true)][string]$credName
)

$inFile = "${env:\userprofile}\credentials\$credName.creds"
$Credential = Get-Credential
$Credential | Export-CliXml -Path $inFile
