@echo off
REM === ZIP ALL Files in Current Directory ===

REM Ambil nama folder saat ini
for %%I in (.) do set FOLDERNAME=%%~nxI

REM Buat nama file ZIP dengan timestamp
set ZIPFILE=%FOLDERNAME%_%DATE:~6,4%%DATE:~3,2%%DATE:~0,2%_%TIME:~0,2%%TIME:~3,2%.zip

REM Hilangkan spasi pada jam
set ZIPFILE=%ZIPFILE: =0%

echo Membuat ZIP dari seluruh isi folder: %FOLDERNAME%
echo Output: %ZIPFILE%

powershell -Command "Compress-Archive -Path '*' -DestinationPath '%ZIPFILE%' -Force"

if exist "%ZIPFILE%" (
    echo Selesai! File ZIP berhasil dibuat.
) else (
    echo Gagal membuat ZIP.
)

pause
