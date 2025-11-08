# Folder `var`

Folder ini berisi berbagai **batch script (CMD)** dan utilitas kecil untuk mempermudah pekerjaan sehari-hari di Windows, termasuk manipulasi file, clipboard, dan manajemen teks.

## Daftar Skrip

| Skrip | Fungsi | Catatan |
|-------|--------|---------|
| `cpy.bat` | Menyalin isi file ke clipboard | Bisa menyalin 1 file atau beberapa file sekaligus (`*.txt`) |
| `pst.bat` | Menempelkan isi clipboard ke file | Menimpa file yang sudah ada, atau membuat file baru jika belum ada. Default encoding: UTF-8. Bisa memakai wildcard `*.html` (non-rekursif). |
| `ren.bat` | Mengubah nama file | Menyederhanakan rename file melalui prompt. |
| `Timer/Pomodoro scripts` | Timer 25 menit kerja + 5 menit break | Memberikan notifikasi di terminal dan beep/motivasi |
| `codehere.bat` | Membuka VS Code di folder tertentu | Menggunakan `code .` dari command prompt |
| `pst.bat (versi lama)` | Paste clipboard secara rekursif | Menimpa semua file matching pattern di folder + subfolder |
| `multitools` | Kumpulan batch/Powershell untuk sysadmin, forensik, dan pengetesan jaringan | Misal: scan IP, port, RPC dump, reset Office |

## Cara Penggunaan

### 1. Menyalin file ke clipboard
```bat
cpy file.txt
cpy *.js
2. Menempelkan clipboard ke file
bat
Copy code
pst index.html        # menimpa atau membuat index.html di folder saat ini
pst *.html            # menimpa atau membuat semua file .html di folder saat ini
3. Mengubah nama file
bat
Copy code
ren oldfile.txt newfile.txt
4. Timer / Pomodoro
bat
Copy code
timer.bat             # menjalankan timer kerja 25 menit + istirahat 5 menit
5. Membuka VS Code di folder aktif
bat
Copy code
codehere.bat
Catatan
Semua skrip menggunakan Windows CMD/Batch.

Beberapa skrip membutuhkan PowerShell (misal pst.bat).

File yang dibuat atau ditimpa oleh skrip menggunakan UTF-8 encoding.

pst.bat versi non-rekursif hanya mempengaruhi folder saat ini, bukan subfolder.

Pastikan menjalankan command prompt dengan hak akses yang sesuai jika menimpa file sistem atau file di folder lain.
