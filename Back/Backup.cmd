@echo off
set t0=%time%

:: change working dir
%~d0
cd %~p0

type Backup.txt
echo ----------------------------
echo Close file blocking programs
echo ----------------------------
timeout 30

:: create dest dir
set dst1=%~dp0..\Back-%date:~6,4%-%date:~3,2%-%date:~0,2%
md %dst1%

:: loop over folders from file
for /F "tokens=*" %%A in (Backup.txt) do call :zip %%A
goto end

:: zip single folder
:zip
set f1=%~1
if /i "%f1:~0,1%"=="#" goto :EOF
set f2=%f1:\=_%
set f2=%f2::=_%
7za.exe a -r "%dst1%\%f2%.zip" "%f1%\*.*"
goto :EOF

:end
echo ran from %t0% to %time%
pause
