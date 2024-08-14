param (
    [Parameter(Mandatory)][string]$File,
    [Parameter()][string]$FPS = 25,
    [Parameter()][int32]$OutputWidth = 1280,
    [Parameter()][int32]$Loop = 0,
    [Parameter()][string]$OutputFile = ""
)

if (-not $OutputFile) {
    $OutputFile = (Split-Path -Path $File -LeafBase) + ".gif"
}

$cmd = "ffmpeg.exe -i '$File' -vf 'fps=$FPS,scale=$OutputWidth`:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse' -loop $Loop '$OutputFile'"
Write-Host -ForegroundColor Gray -Object "Running command: $cmd"
Invoke-Expression -Command $cmd
