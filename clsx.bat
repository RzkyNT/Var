setlocal ENABLEDELAYEDEXPANSION

:: Gabungkan semua argumen jadi satu pesan
set "MSG=%*"
if "%MSG%"=="" set "MSG=Welcome To Your Terminal"

:: Jalankan PowerShell (1 baris aman, tanpa ^)
powershell -NoProfile -ExecutionPolicy Bypass ^
  "Clear-Host; $w=[Console]::WindowWidth; function Center([string]$s,[string]$color='White'){ $pad=[math]::Max(0,($w/2 - ($s.Length/2))); Write-Host (' ' * $pad + $s) -ForegroundColor $color }; $ascii=@('  ______ _      _____   __  __  __  __  ',' |  ____| |    |  __ \ / _|/ _|/ _|/ _| ',' | |__  | | ___| |  | | |_ | |_ | |_ |_  ',' |  __| | |/ _ \ |  | |  _||  _||  _|  _| ','  | |    | |  __/ |__| | | | |  | |  | |   ','   |_|    |_|\___|_____/|_| |_|  |_|  |_|   '); foreach($l in $ascii){ Center $l 'Cyan' }; Center ''; Center ('User: ' + $env:USERNAME + '@' + $env:COMPUTERNAME) 'Yellow'; Center ('Message: %MSG%') 'Green'; Center ((Get-Date).ToString('yyyy-MM-dd HH:mm:ss')) 'DarkGray'; Write-Host ''"


