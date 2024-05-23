#requires -RunAsAdministrator
param (
    [Parameter()][string]$ConfigurationFilePath="$PSScriptRoot\configuration.dsc.yaml"
)

Invoke-Expression -Command "winget configure -f '$ConfigurationFilePath' --accept-configuration-agreements --disable-interactivity --verbose"
