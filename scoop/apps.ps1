function Remove-Apps {
    param (
        [Parameter(Mandatory)][string[]]$InstalledApps,
        [Parameter(Mandatory)][string[]]$TargetApps
    )

    $extraApps = $InstalledApps | Where-Object { $_ -NotIn $TargetApps }

    if ($extraApps.Count -gt 0) {
        Write-Host "`nFound $($extraApps.Count) app(s) not in manifest:" -ForegroundColor Yellow
        Write-Host "--> $($extraApps -Join `", `")" -ForegroundColor Yellow

        $removeApps = Read-Host -Prompt "`nWould you like to remove this/these (y/n)"

        if ($removeApps -eq "y") {
            $extraApps | Foreach-Object -Process {
                Write-Host ""
                Write-Host "Removing $_"
                scoop uninstall $_
            }
        }
    }
}

function Add-Apps {
    param (
        [Parameter(Mandatory)][string[]]$InstalledApps,
        [Parameter(Mandatory)][string[]]$TargetApps
    )

    $missingApps = $TargetApps | Where-Object { $_ -notin $InstalledApps }

    if ($missingApps.Count -gt 0) {
        Write-Host "`nFound $($missingApps.Count) app(s) not installed:" -ForegroundColor Yellow
        Write-Host "--> $($missingApps -Join `", `")" -ForegroundColor Yellow

        $addApps = Read-Host -Prompt "`nWould you like to add this/these (y/n)"

        if ($addApps -eq "y") {
            $missingApps | Foreach-Object -Process {
                Write-Host ""
                Write-Host "Adding $_"
                scoop install $_
            }
        }
    }
}

function Sync-Apps {
    param(
        [Parameter(Mandatory)][string[]]$TargetApps
    )

    $installedApps = $(scoop list | Select-Object -ExpandProperty "Name")

    Write-Host "`nInstalled apps:"
    Write-Host $($InstalledApps -join ", ")

    Write-Host "`nTarget apps:"
    Write-Host $($TargetApps -join ", ")

    Remove-Apps -InstalledApps $InstalledApps -TargetApps $TargetApps
    Add-Apps -InstalledApps $InstalledApps -TargetApps $TargetApps

}
