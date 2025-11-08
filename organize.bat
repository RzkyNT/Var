@echo off
setlocal enabledelayedexpansion
title File Organizer - Flexible Path
echo ==========================================
echo       INTERACTIVE FILE ORGANIZER
echo ==========================================
echo.

:: -----------------------------
:: Default source folder (Documents)
:: -----------------------------
set "DEFAULT_SOURCE=%USERPROFILE%\Documents"

:: -----------------------------
:: UNDO mode
:: -----------------------------
if /I "%~1"=="undo" (
    set "TARGET=%CD%"
    set "LOGFILE=%TARGET%\organizer.log"
    set "UNDOFILE=%TARGET%\undo.log"
    call :UNDO
    exit /b
)

:: -----------------------------
:: Ask source folder (default = current folder)
:: -----------------------------
echo Current folder: %CD%
set /p "input=Masukkan folder sumber (Enter = current folder): "
if "%input%"=="" (
    set "TARGET=%CD%"
) else (
    set "TARGET=%input%"
)
echo Menggunakan folder sumber: "%TARGET%"
echo.

:: -----------------------------
:: Log files
:: -----------------------------
set "LOGFILE=%TARGET%\organizer.log"
set "UNDOFILE=%TARGET%\undo.log"
> "%LOGFILE%" echo [Log - %date% %time%]
> "%UNDOFILE%" echo [Undo - %date% %time%]

:: -----------------------------
:: Collect unique extensions
:: -----------------------------
set "EXTLIST="
for %%F in ("%TARGET%\*") do (
    if not exist "%%~fF\" (
        set "fname=%%~nxF"
        if /I not "!fname!"=="%~nx0" if /I not "!fname!"=="organizer.log" if /I not "!fname!"=="undo.log" (
            set "ext=%%~xF"
            if defined ext (
                set "ext=!ext:~1!"
                echo !EXTLIST! | findstr /I "\<!ext!\>" >nul || (
                    set "EXTLIST=!EXTLIST! !ext!"
                )
            )
        )
    )
)

:: -----------------------------
:: Ask folder for each extension
:: -----------------------------
for %%E in (!EXTLIST!) do (
    call :ASK_FOLDER "%%E"
)

:: -----------------------------
:: Move files
:: -----------------------------
echo.
echo ==========================================
echo     MEMULAI PEMINDAHAN FILE
echo ==========================================
echo.

for %%F in ("%TARGET%\*") do (
    if not exist "%%~fF\" (
        set "fname=%%~nxF"
        if /I not "!fname!"=="%~nx0" if /I not "!fname!"=="organizer.log" if /I not "!fname!"=="undo.log" (
            set "ext=%%~xF"
            if defined ext (
                set "ext=!ext:~1!"
                call set "dest=%%map_!ext!%%"
                if defined dest (
                    echo Memindahkan "!fname!" ke "!dest!\"
                    echo [MOVE] "!TARGET!\!fname!" -> "!dest!\!fname!" >> "%LOGFILE%"
                    echo "!TARGET!\!fname!|!dest!\!fname!" >> "%UNDOFILE%"
                    move /Y "!TARGET!\!fname!" "!dest!\" >nul 2>&1
                )
            )
        )
    )
)

echo.
echo ==========================================
echo Semua file sudah diatur.
echo Log tersimpan di: %LOGFILE%
echo Untuk mengembalikan posisi file, jalankan:
echo     "%~nx0" undo
echo ==========================================
pause
exit /b

:: -----------------------------
:: Ask folder
:: -----------------------------
:ASK_FOLDER
set "ext=%~1"
set "ext=%ext:"=%"
echo Ditemukan ekstensi baru: .%ext%
set /p "folder=Masukkan nama/path folder penyimpanan untuk ekstensi .%ext% (Enter = default: %TARGET%\%ext%): "
set "folder=%folder:"=%"
if "%folder%"=="" set "folder=%TARGET%\%ext%"
echo Membuat folder jika belum ada: "%folder%"
if not exist "%folder%" mkdir "%folder%"
set "map_%ext%=%folder%"
exit /b

:: -----------------------------
:: UNDO
:: -----------------------------
:UNDO
echo ==========================================
echo           MODE UNDO AKTIF
echo ==========================================
if not exist "%UNDOFILE%" (
    echo File undo.log tidak ditemukan.
    pause
    exit /b
)
for /f "usebackq tokens=1* delims=|" %%A in ("%UNDOFILE%") do (
    set "src=%%~A"
    set "dest=%%~B"
    set "src=!src:"=!
    set "dest=!dest:"=!
    if exist "!dest!" (
        echo Mengembalikan "!dest!" -> "!src!"
        move /Y "!dest!" "!src!" >nul 2>&1
        echo [UNDO] "!dest!" -> "!src!" >> "%LOGFILE%"
    )
)
echo Semua file telah dikembalikan.
pause
exit /b
