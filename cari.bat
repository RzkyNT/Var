@echo off
:: findfile.bat — Cari file berdasarkan nama/pola di seluruh subfolder
:: Usage:
::   findfile keyword
::   findfile *.log
::   findfile report
::   findfile "index.html"

if "%~1"=="" (
    echo.
    echo ?? Usage: findfile keyword
    echo Contoh:
    echo   findfile *.log
    echo   findfile report
    echo   findfile index.html
    exit /b
)

setlocal ENABLEDELAYEDEXPANSION
set "SEARCH=%~1"
set "LOGFILE=%cd%\hasil_cari.txt"
del "%LOGFILE%" >nul 2>&1

echo.
echo ===========================================================
echo ??  Mencari file "%SEARCH%" di folder ini dan subfolder...
echo ===========================================================
echo.

:: Simpan hasil sementara
dir /b /s | findstr /I "%SEARCH%" > "%temp%\findfile.tmp"

if %errorlevel% neq 0 (
    echo ? Tidak ditemukan file yang cocok dengan "%SEARCH%".
    exit /b
)

set /a COUNT=0
for /f "usebackq delims=" %%A in ("%temp%\findfile.tmp") do (
    set /a COUNT+=1
    set "path=%%~A"
    set "folder=%%~dpA"
    echo [[92m!COUNT![0m] [96m%%~nxA[0m
    echo     [90m!folder![0m
    echo %%~A>>"%LOGFILE%"
)
echo.
echo ? %COUNT% file ditemukan. Disimpan ke "%LOGFILE%"
echo.

del "%temp%\findfile.tmp" >nul 2>&1
endlocal

