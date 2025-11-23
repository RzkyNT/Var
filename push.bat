@echo off
REM push.bat - Commit & push dengan satu perintah

if "%~1"=="" (
    echo Gunakan: push "pesan commit"
    echo Contoh: push "Fix bug autofill textarea"
    exit /b
)

git add .
git commit -m "%~1"
git push

echo.
echo ============================
echo   Commit & Push Selesai 🚀
echo ============================
pause

