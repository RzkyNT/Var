@echo off
REM ren.bat - Safe rename utility with help info

REM Jika tidak ada argumen, tampilkan info
if "%~1"=="" (
    echo =========================================
    echo          Rename File Utility
    echo =========================================
    echo Usage:
    echo   ren oldfilename.ext newfilename.ext
    echo Example:
    echo   ren cpy.bat cpu.bat
    echo =========================================
    pause
    exit /b
)

REM Ambil argumen pertama dan kedua
set "OLD=%~1"
set "NEW=%~2"

REM Cek apakah argumen lengkap
if "%NEW%"=="" (
    echo ERROR: Missing new filename.
    echo Usage: ren oldfilename.ext newfilename.ext
    pause
    exit /b 1
)

REM Cek apakah file lama ada
if not exist "%OLD%" (
    echo ERROR: File "%OLD%" not found!
    pause
    exit /b 1
)

REM Rename file
ren "%OLD%" "%NEW%"
echo File "%OLD%" renamed to "%NEW%"
pause

