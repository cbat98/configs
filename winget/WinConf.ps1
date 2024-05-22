#requires -RunAsAdministrator

Invoke-Expression -Command "winget configure -f .\configuration.dsc.yaml --accept-configuration-agreements --disable-interactivity --verbose"