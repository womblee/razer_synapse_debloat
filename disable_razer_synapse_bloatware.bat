@echo off
echo ================================================
echo  Razer Synapse 3/4 Bloatware Removal Script
echo ================================================
echo.
echo This script will:
echo - Disable non-essential Razer services (both Synapse 3 and 4)
echo - Keep macro functionality intact
echo - Disable telemetry and auto-updates
echo - Preserve RazerAppEngine processes for hardware control
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
echo [1/5] Stopping and disabling bloatware services...

REM Stop and disable bloatware services (keep macro functionality)
sc stop "Razer Game Scanner Service" >nul 2>&1
sc config "Razer Game Scanner Service" start= disabled >nul 2>&1
echo - Disabled Razer Game Scanner Service

sc stop "Razer Central Service" >nul 2>&1
sc config "Razer Central Service" start= disabled >nul 2>&1
echo - Disabled Razer Central Service

sc stop "RzActionSvc" >nul 2>&1
sc config "RzActionSvc" start= disabled >nul 2>&1
echo - Disabled RzActionSvc (overlay features)

REM Set these to manual (they might be needed occasionally)
sc config "RazerIngameEngine" start= demand >nul 2>&1
echo - Set RazerIngameEngine to manual startup

sc config "RzKLService" start= demand >nul 2>&1
echo - Set RzKLService to manual startup

echo.
echo [2/5] Keeping essential services enabled...
REM Ensure critical services remain enabled (Synapse 3 & 4)
sc config "Razer Synapse Service" start= auto >nul 2>&1
echo - Razer Synapse Service: ENABLED (required for macros)

sc config "RzDeviceEngine" start= auto >nul 2>&1
echo - RzDeviceEngine: ENABLED (required for device communication)

REM Don't disable RazerAppEngine processes - they're essential for Synapse 4
echo - RazerAppEngine processes: PRESERVED (required for Synapse 4 hardware control)

echo.
echo [3/5] Disabling startup programs...
REM Remove Razer programs from startup
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "RzWizard" /f >nul 2>&1
echo - Removed Razer Central from startup

echo.
echo [4/5] Disabling telemetry and updates...
REM Disable telemetry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\RzWizard" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\RzWizard" /v "TelemetryEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo - Disabled telemetry

REM Disable auto-updates (both Synapse 3 & 4)
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse3\Installer" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse3\Installer" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse4\Installer" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse4\Installer" /v "AutoUpdate" /t REG_DWORD /d 0 /f >nul 2>&1
echo - Disabled automatic updates

echo.
echo [5/5] Killing running bloatware processes...
taskkill /f /im "Razer Central.exe" >nul 2>&1
taskkill /f /im "RzActionSvc.exe" >nul 2>&1
taskkill /f /im "RazerGameScanner.exe" >nul 2>&1
echo - Terminated bloatware processes

echo.
echo ================================================
echo                   COMPLETED
echo ================================================
echo.
echo Changes made:
echo - Disabled Razer Game Scanner Service
echo - Disabled Razer Central Service  
echo - Disabled RzActionSvc
echo - Set non-essential services to manual
echo - Kept Synapse Service and RzDeviceEngine enabled
echo - Preserved RazerAppEngine processes (Synapse 4)
echo - Disabled telemetry and auto-updates (both versions)
echo - Removed startup programs
echo.
echo Your mouse macros should work normally in both Synapse 3 and 4.
echo Reboot recommended to ensure all changes take effect.
echo.
echo To undo these changes, run the restore script.
echo.
pause