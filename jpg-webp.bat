@echo off
REM ------------------------------
REM Convert all JPG/JPEG images in current folder and subfolders
REM to WebP format inside web_output folder
REM Subdirectory structure inside RE is preserved
REM Concurrency limited to 8 processes
REM ------------------------------

set "CWEBP=C:\tools\libwebp-0.4.1-windows-x64\libwebp-0.4.1-windows-x64\bin\cwebp.exe"
set "INPUT=%cd%"
set "OUTPUT=%INPUT%\converted"
set MAXJOBS=100

if not exist "%CWEBP%" (
    echo ERROR: cwebp.exe not found at %CWEBP%
    pause
    exit /b
)

echo Creating output folder: %OUTPUT%
mkdir "%OUTPUT%" >nul 2>&1

setlocal enabledelayedexpansion
set JOBS=0

REM List all JPG/JPEG files recursively
for /f "delims=" %%F in ('dir /b /s *.jpg *.jpeg 2^>nul') do (
    REM Compute path relative to INPUT
    set "fullpath=%%F"
    set "relpath=!fullpath:%INPUT%\=!"

    REM Replace .jpg or .jpeg with .webp
    set "outpath=%OUTPUT%\!relpath!"
    set "outpath=!outpath:.jpg=.webp!"
    set "outpath=!outpath:.jpeg=.webp!"

    REM Create output folder if it doesn't exist
    for %%D in ("!outpath!") do (
        if not exist "%%~dpD" mkdir "%%~dpD"
    )

    REM Convert
    echo Converting %%F ...
    start /b "" "%CWEBP%" -q 80 "%%F" -o "!outpath!"

    REM Track running jobs
    set /a JOBS+=1
    if !JOBS! geq %MAXJOBS% (
        call :WAITJOBS
        set JOBS=0
    )
)

REM Wait for any remaining jobs
call :WAITJOBS

echo All images converted inside %OUTPUT%
pause
exit /b

:WAITJOBS
REM Wait until no cwebp.exe process is running
:WAITLOOP
tasklist /fi "imagename eq cwebp.exe" | find /i "cwebp.exe" >nul
if %errorlevel%==0 (
    timeout /t 2 >nul
    goto :WAITLOOP
)
exit /b
