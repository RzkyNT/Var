@echo off
REM === unzip Command=== 
REM Cara pakai: unzip nama_file.zip [tujuan_folder]
REM Contoh: unzip WA_Sender_Free.zip
REM Atau: unzip WA_Sender_Free.zip hasil_extract

if "%~1"=="" (
    echo Usage: unzip file.zip [output_folder]
    exit /b
)

set ZIPFILE=%~1

if "%~2"=="" (
    set DEST=%~n1
) else (
    set DEST=%~2
)

echo Mengekstrak %ZIPFILE% ke folder %DEST% ...
powershell -Command "Expand-Archive -Path '%ZIPFILE%' -DestinationPath '%DEST%' -Force"

if exist "%DEST%" (
    echo Selesai! File diekstrak ke: %DEST%
) else (
    echo Gagal mengekstrak. Pastikan nama file ZIP benar.
)
pause
