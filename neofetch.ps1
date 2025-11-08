cls
<#
neofetch-matrix.ps1 — Matrix-style neofetch (Realtime + Animated Background)
Menampilkan info sistem Windows secara live (CPU, RAM, Disk, Uptime, IP, Time)
dengan tampilan 2 kolom dan efek Matrix code rain di background.
#>

# --- Warna
$Green = "Green"
$Gray  = "DarkGray"
$White = "White"

# --- Progress bar
function Progress-Bar($value, $total, $width=20) {
    if ($total -eq 0) { return "[--------------------]" }
    $pct = [math]::Round(($value / $total) * 100)
    $filled = [math]::Round(($pct / 100) * $width)
    $bar = ("█" * $filled).PadRight($width, "░")
    return "[${bar}] $pct%"
}

# --- Matrix intro
function Matrix-RainIntro($durationSec=2) {
    $chars = @("0","1","░","▒","▓")
    $cols = [Console]::WindowWidth
    $end = (Get-Date).AddSeconds($durationSec)
    while ((Get-Date) -lt $end) {
        $line = ""
        for ($i=0; $i -lt $cols; $i++) {
            $line += $chars[(Get-Random -Minimum 0 -Maximum $chars.Count)]
        }
        Write-Host $line -ForegroundColor Green
        Start-Sleep -Milliseconds 50
    }
    Clear-Host
}

# --- Matrix background loop (as job)
function Start-MatrixRainBackground {
    Start-Job -Name "MatrixRain" -ScriptBlock {
        $chars = @("0","1","░","▒","▓")
        $w = [Console]::WindowWidth
        $h = [Console]::WindowHeight
        while ($true) {
            $x = Get-Random -Minimum 50 -Maximum ($w - 2)
            $y = Get-Random -Minimum 10 -Maximum ($h - 2)
            $c = $chars[(Get-Random -Minimum 0 -Maximum $chars.Count)]
            [Console]::SetCursorPosition($x, $y)
            Write-Host $c -ForegroundColor DarkGreen -NoNewline
            Start-Sleep -Milliseconds (Get-Random -Minimum 30 -Maximum 120)
        }
    } | Out-Null
}

# --- ASCII kiri
$ascii = @(
"╔════════════════╗",
"║     _____      ║",
"║ ⚡ |  __ \     ║",
"║    | |__) | ⚡ ║",
"║    |  _  /     ║",
"║ ⚡ | | \ \     ║",
"║    |_|  \_\    ║",
"╚════════════════╝"
)

# --- Intro
cls
Matrix-RainIntro -durationSec 2
Write-Host "Collecting system info..." -ForegroundColor Green
Start-Sleep -Seconds 1
cls

# --- Static info
$os = Get-CimInstance Win32_OperatingSystem
$cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
$gpu = (Get-CimInstance Win32_VideoController | Select-Object -First 1).Name
$cs  = Get-CimInstance Win32_ComputerSystem
$totalMemGB = [math]::Round($cs.TotalPhysicalMemory / 1GB, 2)
$disk = Get-PSDrive -Name C
$totalDisk = [math]::Round(($disk.Used + $disk.Free)/1GB,2)
$ip = (Get-NetIPAddress -AddressFamily IPv4 -ErrorAction SilentlyContinue |
       Where-Object { $_.IPAddress -notlike '169.*' -and $_.IPAddress -ne '127.0.0.1' } |
       Select-Object -First 1 -ExpandProperty IPAddress)

# --- Layout kiri (logo)
for ($i=0; $i -lt $ascii.Count; $i++) {
    [Console]::SetCursorPosition(0, $i)
    Write-Host $ascii[$i] -ForegroundColor Green
}

# --- Static text kanan
$staticInfo = @(
"User: $env:USERNAME@$env:COMPUTERNAME",
"OS: $($os.Caption)",
"Version: $($os.Version)",
"Arch: $($os.OSArchitecture)",
"CPU: $($cpu.Name)",
"Cores/Threads: $($cpu.NumberOfCores)/$($cpu.NumberOfLogicalProcessors)",
"GPU: $gpu",
"IP: $ip",
"Shell: PowerShell $($PSVersionTable.PSVersion)"
)

$baseX = 26
$baseY = 0
for ($i=0; $i -lt $staticInfo.Count; $i++) {
    [Console]::SetCursorPosition($baseX, $baseY + $i)
    Write-Host $staticInfo[$i] -ForegroundColor White
}

# --- Dynamic field start setelah info statis
$yDynamicStart = $baseY + $staticInfo.Count + 2

# --- Jalankan background Matrix Rain
Start-MatrixRainBackground

# --- Loop realtime info
while ($true) {
    try {
        $os = Get-CimInstance Win32_OperatingSystem -ErrorAction SilentlyContinue
        $boot = [Management.ManagementDateTimeConverter]::ToDateTime($os.LastBootUpTime)
        $upt = (Get-Date) - $boot
        $Uptime = "{0}d {1}h {2}m {3}s" -f $upt.Days, $upt.Hours, $upt.Minutes, $upt.Seconds

        $cpuLoad = (Get-Counter '\Processor(_Total)\% Processor Time').CounterSamples.CookedValue
        $cpuPct = [math]::Round($cpuLoad, 1)

        $freeMemGB = [math]::Round(($os.FreePhysicalMemory / 1MB), 2)
        $usedMemGB = [math]::Round($totalMemGB - $freeMemGB, 2)

        $disk = Get-PSDrive -Name C
        $usedDisk = [math]::Round($disk.Used/1GB,2)

        $timeNow = (Get-Date).ToString("HH:mm:ss")

        [Console]::SetCursorPosition($baseX, $yDynamicStart)
        Write-Host ("Uptime: ".PadRight(30) + $Uptime + "        ") -ForegroundColor White

        [Console]::SetCursorPosition($baseX, $yDynamicStart + 2)
        Write-Host ("CPU Usage: ".PadRight(30) + (Progress-Bar $cpuPct 100)) -ForegroundColor White

        [Console]::SetCursorPosition($baseX, $yDynamicStart + 4)
        Write-Host ("RAM: ".PadRight(30) + "$usedMemGB GB / $totalMemGB GB".PadRight(15) + (Progress-Bar $usedMemGB $totalMemGB)) -ForegroundColor White

        [Console]::SetCursorPosition($baseX, $yDynamicStart + 6)
        Write-Host ("Disk: ".PadRight(30) + "$usedDisk GB / $totalDisk GB".PadRight(15) + (Progress-Bar $usedDisk $totalDisk)) -ForegroundColor White

        [Console]::SetCursorPosition($baseX, $yDynamicStart + 8)
        Write-Host ("Time: ".PadRight(30) + $timeNow + "        ") -ForegroundColor Gray

        Start-Sleep -Milliseconds 900
    }
    catch {
        Start-Sleep -Seconds 1
    }
}

