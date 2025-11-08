# fakebsod_real.ps1
# Fake Blue Screen (very realistic visual) - safe & non-destructive
# Shows a full-screen blue error screen in console, waits for any key, then restores.

# Save original console state
$raw = $Host.UI.RawUI
$origBg = $raw.BackgroundColor
$origFg = $raw.ForegroundColor
$origTitle = $Host.UI.RawUI.WindowTitle
$origCursor = [console]::CursorVisible

try {
    # Switch to blue background + bright white text
    $raw.BackgroundColor = 'Blue'
    $raw.ForegroundColor = 'White'
    Clear-Host

    [console]::CursorVisible = $false

    $w = [console]::WindowWidth
    $h = [console]::WindowHeight

    # Typical BSOD lines (generic, non-actionable)
    $lines = @(
        ":( ",
        "",
        "Your PC ran into a problem and needs to restart. We're just collecting some error info, and then we'll restart for you.",
        "",
        "If you'd like to know more, you can search online later for this error: FAKE_BSOD_0001",
        "",
        "",
        "*** STOP CODE: 0x000000FAKE",
        "",
        "",
        "For more information about this issue and possible fixes, visit https://support.microsoft.com",
        "",
        "",
        "Press any key to continue..."
    )

    # Expand with additional realistic-looking technical section (not actionable)
    $tech = @(
        "",
        "Collecting data for crash dump ...",
        "Initializing error reporting ...",
        "",
        "Parameters:",
        "  0x00000000 0x00000000 0x00000000 0x00000000"
    )

    # Merge chosen content for layout (top-left style like real BSOD)
    # We'll print left-aligned with some left padding to mimic real BSOD spacing
    $leftPad = 3

    # Compose screen: top area with sad face and main message centered-ish,
    # and lower technical block left-aligned.
    Clear-Host

    # Print a top block (some vertical padding)
    $topPad = 2
    for ($i=0; $i -lt $topPad; $i++) { Write-Host "" }

    # Sad face large-ish and main message (centered)
    $sad = $lines[0]
    $sadPad = [math]::Max(0, [math]::Floor(($w - $sad.Length) / 2))
    Write-Host (" " * $sadPad + $sad) -ForegroundColor White

    Write-Host ""  # spacer

    # Print the main paragraph centered to approximate BSOD wording
    $mainText = $lines[2]
    $wrapWidth = [math]::Max(40, [math]::Floor($w * 0.7))
    $wrapped = ($mainText -split " (?=.)" ) -join " "  # ensure string
    # Simple word-wrap
    $words = $mainText.Split(" ")
    $acc = ""
    $centerBlock = @()
    foreach ($word in $words) {
        if ($acc.Length + $word.Length + 1 -gt $wrapWidth) {
            $centerBlock += $acc.Trim()
            $acc = $word + " "
        } else {
            $acc += $word + " "
        }
    }
    if ($acc.Trim().Length -gt 0) { $centerBlock += $acc.Trim() }

    foreach ($ln in $centerBlock) {
        $pad = [math]::Max(0, [math]::Floor(($w - $ln.Length) / 2))
        Write-Host (" " * $pad + $ln)
    }

    Write-Host ""  # spacer

    # Print the "search online" line centered
    $searchLine = $lines[4]
    $padS = [math]::Max(0, [math]::Floor(($w - $searchLine.Length) / 2))
    Write-Host (" " * $padS + $searchLine)

    Write-Host ""  # spacer

    # Print stop code centered
    $stop = $lines[7]
    $padStop = [math]::Max(0, [math]::Floor(($w - $stop.Length) / 2))
    Write-Host (" " * $padStop + $stop) -ForegroundColor White

    # Blank lines until technical block near bottom-left
    $currentLine = 10
    while ($currentLine -lt ($h - ($tech.Count + 4))) {
        Write-Host ""
        $currentLine++
    }

    # Technical block left-aligned with small left padding
    foreach ($t in $tech) {
        Write-Host (" " * $leftPad + $t)
    }

    # Footer instruction centered
    $footer = $lines[-1]
    $padF = [math]::Max(0, [math]::Floor(($w - $footer.Length) / 2))
    for ($i=0; $i -lt 2; $i++) { Write-Host "" }
    Write-Host (" " * $padF + $footer) -ForegroundColor Yellow

    # Wait for any key (no Enter)
    [void][console]::ReadKey($true)
}
finally {
    # restore
    $raw.BackgroundColor = $origBg
    $raw.ForegroundColor = $origFg
    $Host.UI.RawUI.WindowTitle = $origTitle
    [console]::CursorVisible = $origCursor
    Clear-Host
}

