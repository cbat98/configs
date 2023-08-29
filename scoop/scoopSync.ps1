function Get-ExtraPackages {
	$extraPackages = @()

	foreach($package in $installedPackages) {
 		Write-Host "$package"

		if (!$packages.Contains($package)) {
			$extraPackages += $package
		}
	}

	return $extraPackages
}

function Get-NewPackages {
	$newPackages = @()

	foreach ($package in $packages) {
		if (!$installedPackages.Contains($package)) {
			$newPackages += $package
		}
	}	

	return $newPackages
}

function Remove-ExtraPackages {
	if ($extraPackages.count -gt 0) {
		Write-Host "`nFound extra packages not in packages.txt"
		Write-Host "`nExtra apps:"
		Write-Host ($extraPackages -join ", ")

		$removeExtraPackages = Read-Host -Prompt "`nDo you want these to be removed? (y/N)"
		if ($removeExtraPackages -eq "y") {
			Invoke-Expression -Command "scoop.ps1 uninstall $($extraPackages -join ' ')"
		}
	}
}

function Install-NewPackages {
	if ($newPackages.count -gt 0) {
		Write-Host "`nFound packages to install" 
		Write-Host "`nNew apps:"
		Write-Host ($newPackages -join ", ")

		$installNewPackages = Read-Host -Prompt "`nDo you want these to be installed? (y/N)"
		if ($installNewPackages -eq "y") {
			Invoke-Expression -Command "scoop.ps1 install $($newPackages -join ' ')"
		}
	}
}

function Sync-Packages {
	Write-Host "Getting list of installed applications`n"

	$installedPackages = Invoke-Expression "scoop.ps1 list" | Select-Object -ExpandProperty "name" 

	$extraPackages = Get-ExtraPackages
	$newPackages = Get-NewPackages

	Remove-ExtraPackages
	Install-NewPackages
}

function Update-Scoop {
	Write-Host "`nUpdating all applications"

	Invoke-Expression -Command "scoop.ps1 update"
	Invoke-Expression -Command "scoop.ps1 update *"
	Invoke-Expression -Command "scoop.ps1 cleanup *"
}

$manifestPath = "$PSScriptRoot\manifest.json"
$manifest = Get-Content -Path $manifestPath | ConvertFrom-Json

$packages = $manifest | Select-Object -ExpandProperty "packages"

Sync-Packages
Update-Scoop
