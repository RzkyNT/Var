@echo off
REM pst.bat - Paste clipboard content into files (non-recursive, create if not exist)

setlocal enabledelayedexpansion

if "%~1"=="" (
  echo Usage: pst filename
  echo Example: pst index.html
  exit /b 1
)

where powershell >nul 2>&1
if errorlevel 1 (
  echo PowerShell tidak ditemukan. Skrip ini membutuhkan PowerShell.
  exit /b 1
)

set "file=%~1"

echo Menimpa atau membuat "%file%" ...
powershell -NoProfile -Command "Get-Clipboard -Raw | Set-Content -LiteralPath '%cd%\%file%' -Encoding UTF8"

echo Selesai.
endlocal
