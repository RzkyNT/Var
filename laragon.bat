@echo off
REM laragon.bat — otomatis naikan ke admin dan jalankan Laragon.exe

:: --- cek apakah sudah elevated (admin)
>nul 2>&1 net session
if %errorlevel% neq 0 (
    REM belum elevated: jalankan ulang file batch ini dengan UAC
    powershell -Command "Start-Process -FilePath '%~f0' -Verb RunAs"
    exit /b
)

:: --- di sini sudah elevated
REM Default path — ubah jika Laragon Anda ada di tempat lain
set "LARAGON_PATH=C:\laragon\Laragon.exe"

REM coba beberapa lokasi umum jika default tidak ada
if not exist "%LARAGON_PATH%" (
    if exist "C:\Laragon\Laragon.exe" set "LARAGON_PATH=C:\Laragon\Laragon.exe"
)
if not exist "%LARAGON_PATH%" (
    if exist "C:\Program Files\Laragon\Laragon.exe" set "LARAGON_PATH=C:\Program Files\Laragon\Laragon.exe"
)
if not exist "%LARAGON_PATH%" (
    if exist "%~dp0Laragon.exe" set "LARAGON_PATH=%~dp0Laragon.exe"
)

:: jika masih tidak ditemukan, minta input user
if not exist "%LARAGON_PATH%" (
    echo Laragon.exe tidak ditemukan di lokasi standar.
    set /p "LARAGON_PATH=Masukkan path lengkap ke Laragon.exe (mis. C:\laragon\Laragon.exe): "
    if not exist "%LARAGON_PATH%" (
        echo Path tidak valid. Keluar.
        pause
        exit /b 1
    )
)

echo Menjalankan: "%LARAGON_PATH%"
start "" "%LARAGON_PATH%"
exit /b 0

