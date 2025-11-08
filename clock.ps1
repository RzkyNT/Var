# Centered clock with optional message

# Minta input pesan
$message = Read-Host "Masukkan pesan (kosongkan jika tidak ingin pesan)"

Clear-Host

while ($true) {
    $now = Get-Date
    $timeStr = $now.ToString("HH:mm:ss")
    $dateStr = $now.ToString("dddd, dd MMMM yyyy")

    $width = [console]::WindowWidth
    $height = [console]::WindowHeight

    $timePadding = " " * [math]::Max(0, ($width - $timeStr.Length)/2)
    $datePadding = " " * [math]::Max(0, ($width - $dateStr.Length)/2)
    $msgPadding = if ($message -ne "") { " " * [math]::Max(0, ($width - $message.Length)/2) } else { "" }

    # Vertical centering
    $totalLines = if ($message -ne "") { 6 } else { 4 }  # jam + spasi + tanggal [+ pesan + spasi]
    $blankLines = [math]::Max(0, [math]::Floor(($height - $totalLines)/2))

    Clear-Host
    for ($i=0; $i -lt $blankLines; $i++) { Write-Host "" }

    Write-Host "$timePadding$timeStr" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "$datePadding$dateStr" -ForegroundColor White

    if ($message -ne "") {
        Write-Host ""
        Write-Host "$msgPadding$message" -ForegroundColor Yellow
    }

    Start-Sleep -Seconds 1
}

