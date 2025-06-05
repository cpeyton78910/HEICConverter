@echo off
:: Check if script is running as admin
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~dpnx0' -Verb RunAs"
    exit /b
)

echo Removing HEIC Converter startup configuration...

:: Delete the local flag file
echo Deleting startup flag file...
del "%APPDATA%\HEICConverterTaskFlag.txt" /F /Q

:: Remove the scheduled task
echo Removing scheduled startup task...
schtasks /Delete /TN "HEICConverterStartup" /F

echo Cleanup complete!
pause