@echo off
:: findin.bat — Cari teks di semua file (versi Windows grep)
:: Usage:
::   findin "keyword" *.log
::   findin "Error 404" *.txt
::   findin "timeout" *

if "%~1"=="" (
    echo.
    echo ?? Usage: findin "text" [filemask]
    echo Contoh: findin "error" *.log
    echo          findin "failed" *
    exit /b
)

setlocal ENABLEDELAYEDEXPANSION

:: Ambil parameter
set "TEXT=%~1"
set "MASK=%~2"

if "%MASK%"=="" set "MASK=*"

echo.
echo ================================================
echo ??  Mencari "%TEXT%" dalam %MASK% ...
echo ================================================
echo.

:: Gunakan findstr dengan recursive, nomor baris, dan case-insensitive
:: /S = recursive, /N = tampilkan nomor baris, /I = case insensitive, /C: untuk phrase
:: /D:. = current folder only
findstr /S /N /I /C:"%TEXT%" %MASK% > "%temp%\findin.tmp" 2>nul

if %errorlevel% neq 0 (
    echo ? Tidak ditemukan hasil untuk "%TEXT%".
    exit /b
)

:: Tampilkan hasil dengan warna hijau + kuning (file:baris)
for /f "usebackq delims=" %%A in ("%temp%\findin.tmp") do (
    set "line=%%A"
    for /f "tokens=1,2 delims=:" %%i in ("%%A") do (
        echo [[93m%%i[0m:[92m%%j[0m] !line:*%%j:=!
    )
)

echo.
echo ? Pencarian selesai.
echo.

del "%temp%\findin.tmp" >nul 2>&1
endlocal

