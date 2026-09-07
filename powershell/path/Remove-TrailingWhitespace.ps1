param (
    [Parameter()][string]$Path = "."
)

Get-ChildItem -Path $Path -Recurse -File | Where-Object { $_.FullName -notmatch '\\\.git\\' } | ForEach-Object {
    $file = $_.FullName
    $content = Get-Content $file
    if ($null -ne $content) {
        $trimmed = $content | ForEach-Object { $_.TrimEnd(" `t") }
        # Only write if there's a difference
        if (-not ($content -join "`n" -ceq ($trimmed -join "`n"))) {
            $trimmed | Set-Content $file
        }
    }
}
