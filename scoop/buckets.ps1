function Remove-Buckets {
    param (
        [Parameter(Mandatory)][string[]]$InstalledBuckets,
        [Parameter(Mandatory)][string[]]$TargetBuckets
    )

    $extraBuckets = $InstalledBuckets | Where-Object { $_ -NotIn $TargetBuckets }

    if ($extraBuckets.Count -gt 0) {
        Write-Host "`nFound $($extraBuckets.Count) bucket(s) not in manifest:" -ForegroundColor Yellow
        Write-Host "--> $($extraBuckets -Join `", `")" -ForegroundColor Yellow

        $removeBuckets = Read-Host -Prompt "`nWould you like to remove this/these (y/n)"

        if ($removeBuckets -eq "y") {
            $extraBuckets | Foreach-Object -Process {
                Write-Host ""
                Write-Host "Removing $_"
                scoop bucket rm $_
            }
        }
    }
}

function Add-Buckets {
    param (
        [Parameter(Mandatory)][string[]]$InstalledBuckets,
        [Parameter(Mandatory)][string[]]$TargetBuckets
    )

    $missingBuckets = $TargetBuckets | Where-Object { $_ -notin $InstalledBuckets }

    if ($missingBuckets.Count -gt 0) {
        Write-Host "`nFound $($missingBuckets.Count) bucket(s) not installed:" -ForegroundColor Yellow
        Write-Host "--> $($missingBuckets -Join `", `")" -ForegroundColor Yellow

        $addBuckets = Read-Host -Prompt "`nWould you like to add this/these (y/n)"

        if ($addBuckets -eq "y") {
            $missingBuckets | Foreach-Object -Process {
                Write-Host ""
                Write-Host "Adding $_"
                scoop bucket add $_
            }
        }
    }
}

function Sync-Buckets {
    param(
        [Parameter(Mandatory)][string[]]$TargetBuckets
    )
    
    $installedBuckets = $(scoop bucket list | Select-Object -ExpandProperty "Name")

    Write-Host "`nInstalled buckets:"
    Write-Host $($InstalledBuckets -join ", ")

    Write-Host "`nTarget buckets:"
    Write-Host $($TargetBuckets -join ", ")

    Remove-Buckets -InstalledBuckets $InstalledBuckets -TargetBuckets $TargetBuckets
    Add-Buckets -InstalledBuckets $InstalledBuckets -TargetBuckets $TargetBuckets

}
