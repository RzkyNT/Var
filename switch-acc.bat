@echo off
title Git Account Manager
setlocal enabledelayedexpansion

:menu
cls
echo =========================================
echo          Git Account Manager
echo =========================================
echo.
echo Pilih mode:
echo 1. Ganti akun GLOBAL (berlaku untuk semua repo)
echo 2. Ganti akun untuk REPO ini saja
echo 3. Lihat akun Git saat ini
echo 4. Hapus kredensial GitHub (HTTPS)
echo Q. Keluar
echo.
set "mode="
set /p mode="Pilih opsi (1/2/3/4/Q): "

if "%mode%"=="1" goto global
if "%mode%"=="2" goto local
if "%mode%"=="3" goto view
if "%mode%"=="4" goto delcreds
if /i "%mode%"=="Q" goto end

echo Pilihan tidak valid!
pause
goto menu

:global
echo.
echo Pilih akun:
echo 1. PKL Training (pkl-training / pkltrainingpas@gmail.com)
echo 2. RzkyNT (RzkyNT / rizkiakhsansetiawan@gmail.com)
echo 3. Custom
set "choice="
set /p choice="Pilih akun (1/2/3): "

if "%choice%"=="1" (
    git config --global user.name "pkl-training"
    git config --global user.email "pkltrainingpas@gmail.com"
)
if "%choice%"=="2" (
    git config --global user.name "RzkyNT"
    git config --global user.email "rizkiakhsansetiawan@gmail.com"
)
if "%choice%"=="3" (
    set /p uname="Masukkan username: "
    set /p uemail="Masukkan email: "
    git config --global user.name "!uname!"
    git config --global user.email "!uemail!"
)
echo.
echo [OK] Akun GLOBAL berhasil diubah.
pause
goto menu

:local
echo.
if not exist ".git" (
    echo [ERROR] Kamu tidak sedang berada di folder repository Git.
    echo Silakan pindah ke folder repo lalu jalankan lagi.
    pause
    goto menu
)
set /p uname="Masukkan username: "
set /p uemail="Masukkan email: "
git config user.name "!uname!"
git config user.email "!uemail!"
echo.
echo [OK] Akun REPO berhasil diubah.
pause
goto menu

:view
echo.
echo === Akun GLOBAL ===
git config --global user.name
git config --global user.email
echo.
if exist ".git" (
    echo === Akun LOKAL (repo ini) ===
    git config user.name
    git config user.email
) else (
    echo [INFO] Tidak ada repo Git di folder ini.
)
pause
goto menu

:delcreds
echo.
echo Menghapus kredensial GitHub dari Windows Credential Manager...
cmd /c "cmdkey /delete:git:https://github.com" >nul 2>&1
cmd /c "cmdkey /delete:git:https://gitlab.com" >nul 2>&1
echo [OK] Kredensial dihapus. Silakan push/pull untuk login ulang.
pause
goto menu

:end
echo.
echo Keluar dari Git Account Manager...
timeout /t 1 >nul
exit
