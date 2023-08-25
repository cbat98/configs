$packages = Get-Content -Path "packages.txt"
 
$packageList = $packages -join " "

Invoke-Expression -Command "scoop.ps1 install $packageList"

Invoke-Expression -Command "scoop.ps1 update"

Invoke-Expression -Comman "scoop.ps1 update *"

Invoke-Expression -Comman "scoop.ps1 cleanup *"
