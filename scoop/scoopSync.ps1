$packages = Get-Content -Path "$PSScriptRoot\manifest.json" | ConvertFrom-Json | Select-Object -ExpandProperty "packages"

$extraPackages = @()
$newPackages = @()

Write-Host "Getting list of installed applications`n"

$installedPackages = Invoke-Expression "scoop.ps1 list" | Select-Object -ExpandProperty "name" 

$installedPackages | ForEach-Object {
	Write-Host "$_"

	if (!$packages.Contains($_)) {
		$extraPackages += $_
	}
}

$packages | ForEach-Object {
	if (!$installedPackages.Contains($_)) {
		$newPackages += $_
	}
}

if ($extraPackages.count -gt 0) {
	Write-Host "`nFound extra packages not in packages.txt"
	Write-Host "`nExtra apps:"
	Write-Host ($extraPackages -join ", ")

	$removeExtraPackages = Read-Host -Prompt "`nDo you want these to be removed? (y/N)"
	if ($removeExtraPackages -eq "y") {
		Invoke-Expression -Command "scoop.ps1 uninstall $($extraPackages -join ' ')"
	}
}

if ($newPackages.count -gt 0) {
	Write-Host "`nFound packages to install" 
	Write-Host "`nNew apps:"
	Write-Host ($newPackages -join ", ")

	$installNewPackages = Read-Host -Prompt "`nDo you want these to be installed? (y/N)"
	if ($installNewPackages -eq "y") {
		Invoke-Expression -Command "scoop.ps1 install $($newPackages -join ' ')"
	}
}

Write-Host "`nUpdating all applications"

Invoke-Expression -Command "scoop.ps1 update"
Invoke-Expression -Command "scoop.ps1 update *"
Invoke-Expression -Command "scoop.ps1 cleanup *"
