@echo off
:: Jalankan Laragon sebagai Admin
echo Menjalankan Laragon...
powershell -Command "Start-Process 'C:\laragon\laragon.exe' -Verb runAs"

powershell -Command "Start-Process 'C:\Users\RIZQI AHSAN SETIAWAN\Desktop\Laragon Error Log.bat' -Verb runAs"

timeout /t 3 > nul

:: Jalankan VS Code
echo Menjalankan VS Code...
start "" "%LocalAppData%\Programs\Microsoft VS Code\Code.exe"

:: Jalankan Chrome dengan Profile tertentu
echo Menjalankan Chrome dengan Profile 5...
start "" "C:\Program Files\Google\Chrome\Application\chrome.exe" --profile-directory="Profile 5"

exit
