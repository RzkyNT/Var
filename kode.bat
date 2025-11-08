@echo off
REM kode.bat - Git shortcut commands

if "%~1"=="" (
    echo Git shortcut commands:
    echo   kode status       -> git status
    echo   kode log          -> git log --oneline --graph --decorate
    echo   kode kasih        -> git add . && git commit -m "update" && git push
    echo   kode ambil        -> git pull origin main --allow-unrelated-histories
    echo   kode reset        -> git reset --hard HEAD
    exit /b 0
)

set CMD=%~1

if /i "%CMD%"=="status" (
    git status
) else if /i "%CMD%"=="log" (
    git log --oneline --graph --decorate
) else if /i "%CMD%"=="kasih" (
    set /p MSG=Commit message: 
    git add .
    git commit -m "%MSG%"
    git push
) else if /i "%CMD%"=="ambil" (
    git pull origin main --allow-unrelated-histories
) else if /i "%CMD%"=="reset" (
    git reset --hard HEAD
) else (
    echo Unknown command: %CMD%
    echo Use no argument to see available shortcuts
)

