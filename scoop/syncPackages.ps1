$packages = Get-Content -Path "packages.txt"

scoop install ($packages -join " ")

scoop update

scoop update *

scoop cleanup *
