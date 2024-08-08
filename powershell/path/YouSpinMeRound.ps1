param (
    [Parameter()][int32]$Radius = 150,
    [Parameter()][double]$Speed = 2.5,
    [Parameter()][int32]$Framerate = 60,
    [Parameter()][int32]$Duration = -1
)

function MoveMouse {
    param (
        [Parameter(Mandatory)][int32]$XPos,
        [Parameter(Mandatory)][int32]$YPos
    )

    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($XPos, $YPos)
}

function CalibrateBuffer {
    param (
        [Parameter(Mandatory)][int32]$Iterations,
        [Parameter(Mandatory)][int32]$WaitPerIteration
    )

    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

    return 1..$Iterations | ForEach-Object -Process {
        $stopwatch.Reset()
        $stopwatch.Start()

        Start-Sleep -Milliseconds $WaitPerIteration

        $stopwatch.Stop()

        return $stopwatch.ElapsedMilliseconds - $WaitPerIteration
    } | Measure-Object -Average | Select-Object -ExpandProperty Average
}

Add-Type -AssemblyName System.Windows.Forms

$buffer = CalibrateBuffer -Iterations 10 -WaitPerIteration 150

$initialXPos = [System.Windows.Forms.Cursor]::Position.X
$initialYPos = [System.Windows.Forms.Cursor]::Position.Y + $Radius

$msPerFrame = 1000 / $Framerate
$realSpeed = (1 / $Speed) * 25

$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()

for ($i = 0; $i -ne ($Framerate * $Duration); $i++) {
    $stopwatch.Reset()
    $stopwatch.Start()

    $xOffset = $Radius * [System.Math]::Sin($i / $realSpeed)
    $yOffset = $Radius * [System.Math]::Cos($i / $realSpeed + [math]::pi)

    MoveMouse -XPos ($initialXPos + $xOffset) -YPos ($initialYPos + $yOffset)

    $stopwatch.Stop()

    $elapsed = $stopwatch.ElapsedMilliseconds + $buffer

    if ($elapsed -lt $msPerFrame) {
        Start-Sleep -Milliseconds ($msPerFrame - $elapsed)
    }
}
