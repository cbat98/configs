param (
    [Parameter()][string]$Project = "Microlise",
    [Parameter(Mandatory)][string]$Name,
    [Parameter()][switch]$Quick,
    [Parameter()][string]$UrlTemplate = "ssh://azdo.microlise.com:22/MicroliseCollection/#{Project}#/_git/#{Name}#"
)

$repoUrl = $UrlTemplate.Replace("#{Project}#", $Project).Replace("#{Name}#", $Name)

if ($Quick)
{
    & $PSScriptRoot/QuickClone.ps1 -RepoUrl $repoUrl
} else
{
    git clone $repoUrl 
}
