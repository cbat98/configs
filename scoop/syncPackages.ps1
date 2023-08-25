$packages = Get-Content -Path "packages.txt"

$extraPackages = @()
$newPackages = @()

Write-Host "Getting list of installed applications`n"

$installedPackages = Invoke-Expression "scoop.ps1 list" | Select-Object -ExpandProperty "name" 

$installedPackages | ForEach-Object {
	Write-Host "$_"

	if (!$packages.Contains($_)) {
		$extraPackages += $_
	} else {
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
	Write-Host $newPackages

	Invoke-Expression -Command "scoop.ps1 install $newPackages"

	Invoke-Expression -Command "scoop.ps1 update"
	Invoke-Expression -Comman "scoop.ps1 update *"

	Invoke-Expression -Comman "scoop.ps1 cleanup *"
}
