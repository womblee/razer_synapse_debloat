@echo off
echo ================================================
echo   Razer Synapse 3/4 Services Restoration Script
echo ================================================
echo.
echo This script will restore all Razer services to their
echo default settings for both Synapse 3 and 4.
echo.
pause

REM Check for admin privileges
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ERROR: This script requires administrator privileges.
    echo Please right-click and select "Run as administrator"
    pause
    exit /b 1
)

echo.
echo [1/4] Re-enabling all Razer services...

REM Re-enable all services to automatic startup
sc config "Razer Game Scanner Service" start= auto >nul 2>&1
sc start "Razer Game Scanner Service" >nul 2>&1
echo - Re-enabled Razer Game Scanner Service

sc config "Razer Central Service" start= auto >nul 2>&1
sc start "Razer Central Service" >nul 2>&1
echo - Re-enabled Razer Central Service

sc config "RzActionSvc" start= auto >nul 2>&1
sc start "RzActionSvc" >nul 2>&1
echo - Re-enabled RzActionSvc

sc config "RazerIngameEngine" start= auto >nul 2>&1
echo - Set RazerIngameEngine to automatic startup

sc config "RzKLService" start= auto >nul 2>&1
echo - Set RzKLService to automatic startup

sc config "Razer Synapse Service" start= auto >nul 2>&1
sc start "Razer Synapse Service" >nul 2>&1
echo - Ensured Razer Synapse Service is running

sc config "RzDeviceEngine" start= auto >nul 2>&1
sc start "RzDeviceEngine" >nul 2>&1
echo - Ensured RzDeviceEngine is running

echo.
echo [2/4] Restoring startup programs...
REM Restore Razer Central to startup (if it exists)
if exist "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /t REG_SZ /d "\"%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe\" --silent" /f >nul 2>&1
    echo - Restored Razer Central to startup
)

echo.
echo [3/4] Re-enabling telemetry and updates...
REM Re-enable telemetry (default setting)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\RzWizard" /v "TelemetryEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\RzWizard" /v "TelemetryEnabled" /t REG_DWORD /d 1 /f >nul 2>&1
echo - Re-enabled telemetry

REM Re-enable auto-updates (both Synapse 3 & 4)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse3\Installer" /v "AutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse3\Installer" /v "AutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse4\Installer" /v "AutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse4\Installer" /v "AutoUpdate" /t REG_DWORD /d 1 /f >nul 2>&1
echo - Re-enabled automatic updates

echo.
echo [4/4] Starting Razer applications...
REM Start Razer Central if it exists
if exist "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" (
    start "" "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" --silent
    echo - Started Razer Central
)

REM Start Synapse 3 if it exists
if exist "%ProgramFiles(x86)%\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe" (
    start "" "%ProgramFiles(x86)%\Razer\Synapse3\WPFUI\Framework\Razer Synapse 3 Host\Razer Synapse 3.exe"
    echo - Started Razer Synapse 3
)

REM Start Synapse 4 if it exists  
if exist "%ProgramFiles%\Razer\RazerAppEngine\RazerAppEngine.exe" (
    start "" "%ProgramFiles%\Razer\RazerAppEngine\RazerAppEngine.exe"
    echo - Started Razer Synapse 4
)

echo.
echo ================================================
echo                   COMPLETED
echo ================================================
echo.
echo All Razer services have been restored to defaults:
echo - Re-enabled all Razer services
echo - Restored startup programs
echo - Re-enabled telemetry and updates
echo - Started Razer applications
echo.
echo Your Razer software is now back to its original state.
echo All features including macros, RGB, and updates are active.
echo.
pause