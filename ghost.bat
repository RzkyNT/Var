@echo off
REM ghost.bat - Interactive wrapper for ghosttime animation
REM Saves last used color and timer in ghost.cfg

set CONFIG=ghost.cfg

REM --- Load previous settings ---
set COLOR=cyan
set TIMER=
if exist %CONFIG% (
    for /f "tokens=1,2" %%a in (%CONFIG%) do (
        set COLOR=%%a
        set TIMER=-t %%b
    )
)

REM --- Ask for color ---
echo Available colors:
echo   black red green yellow blue magenta cyan white
echo   brightblack brightred brightgreen brightyellow brightblue brightmagenta brightcyan brightwhite
set /p USER_COLOR=Choose color [%COLOR%]: 
if not "%USER_COLOR%"=="" set COLOR=%USER_COLOR%

REM --- Ask for timer ---
set /p USER_TIMER=Set timer in seconds (leave empty for infinite) [%TIMER:~3%]: 
if not "%USER_TIMER%"=="" set TIMER=-t %USER_TIMER%

REM --- Ask for no-focus-pause ---
set NOFOCUS=
set /p USER_NF=Disable pause on lost focus? (y/N) [N]: 
if /i "%USER_NF%"=="y" set NOFOCUS=-nf

REM --- Save settings ---
echo %COLOR% %USER_TIMER% > %CONFIG%

REM --- Run ghosttime ---
echo Running ghosttime with color %COLOR% %TIMER% %NOFOCUS%
ghosttime -c %COLOR% %TIMER% %NOFOCUS%

