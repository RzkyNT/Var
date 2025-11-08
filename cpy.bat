@echo off
REM cpy.bat - Copy file contents to clipboard
REM Usage:
REM   cpy file.txt
REM   cpy "C:\path\index.html"
REM   cpy *.js   (copy semua file ke clipboard)

if "%~1"=="" (
    echo Usage: cpy filename
    exit /b
)

setlocal enabledelayedexpansion

set "src=%~1"

REM Cek apakah file ada
if not exist "%src%" (
    echo File "%src%" tidak ditemukan.
    exit /b
)

REM Jika wildcard, gabungkan semua isi file ke clipboard
for %%F in (%src%) do (
    type "%%~fF"
) | clip

echo Isi file berhasil disalin ke clipboard!
