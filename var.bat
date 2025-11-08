@echo off
REM var.bat - Menampilkan daftar skrip/tools di folder D:\var beserta penjelasan

echo ===================================================
echo        VAR Utilities - Folder D:\var
echo ===================================================
echo.

echo 1. ren.bat         - Rename file dengan aman (interaktif atau via argumen)
echo 2. pst.bat         - Paste isi clipboard ke file tertentu (*.bat, *.txt, dll)
echo 3. cpy.bat         - Copy isi file ke clipboard
echo 4. cari.bat      - Cari teks di semua file (mirip grep di Windows)
echo 5. carix.bat    - Cari file berdasarkan nama/pola di seluruh subfolder
echo 6. organize.bat   - Organize file berdasarkan ekstensi, ada undo
echo 7. kode.bat    - Open current folder di VS Code
echo 8. neofetch.bat    - Jalankan neofetch-matrix.ps1 (info sistem realtime)
echo 9. switch-acc.bat  - Ganti akun Git (global/local), lihat akun, hapus credential
echo 10. switch-php.bat - Ganti Versi PHP
echo.

echo Untuk menjalankan salah satu tool:
echo     ketik nama file .bat tanpa ekstensi
echo Contoh:
echo     ren cpy.bat cpu.bat
echo     pst index.html
echo     findin "error" *.log
echo     switch-acc
echo.

pause

