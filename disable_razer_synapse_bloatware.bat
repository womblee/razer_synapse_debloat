@echo off
echo ================================================
echo  Enhanced Razer Synapse 3/4 Debloat Script
echo ================================================
echo.
echo This script will:
echo - Disable ALL non-essential Razer services
echo - Target memory-heavy Game Manager services (70MB+)
echo - Keep only core device functionality
echo - Preserve macro functionality
echo - Disable telemetry and auto-updates
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
echo [1/6] Stopping and disabling bloatware services...

REM Stop and disable bloatware services
sc stop "Razer Game Scanner Service" >nul 2>&1
sc config "Razer Game Scanner Service" start= disabled >nul 2>&1
echo - Disabled Razer Game Scanner Service

sc stop "Razer Central Service" >nul 2>&1
sc config "Razer Central Service" start= disabled >nul 2>&1
echo - Disabled Razer Central Service

sc stop "RzActionSvc" >nul 2>&1
sc config "RzActionSvc" start= disabled >nul 2>&1
echo - Disabled RzActionSvc (overlay features)

echo.
echo [2/6] Targeting memory-heavy Game Manager services...

REM Disable the memory-heavy game manager services (70MB+ usage)
sc stop "Razer Game Manager Service" >nul 2>&1
sc config "Razer Game Manager Service" start= disabled >nul 2>&1
echo - Disabled Razer Game Manager Service (saves ~70MB)

sc stop "GameManagerService3" >nul 2>&1
sc config "GameManagerService3" start= disabled >nul 2>&1
echo - Disabled GameManagerService3 (saves ~32MB)

REM Set these to manual (they might be needed occasionally)
sc config "RazerIngameEngine" start= demand >nul 2>&1
echo - Set RazerIngameEngine to manual startup

sc config "RzKLService" start= demand >nul 2>&1
echo - Set RzKLService to manual startup

echo.
echo [3/6] Keeping essential services enabled...
REM Ensure critical services remain enabled (Synapse 3 & 4)
sc config "Razer Synapse Service" start= auto >nul 2>&1
echo - Razer Synapse Service: ENABLED (required for macros)

sc config "RzDeviceEngine" start= auto >nul 2>&1
echo - RzDeviceEngine: ENABLED (required for device communication)

REM Keep elevation service (only 1.9MB, sometimes needed)
sc config "Razer Elevation Service" start= auto >nul 2>&1
echo - Razer Elevation Service: ENABLED (lightweight, occasionally needed)

echo - RazerAppEngine processes: PRESERVED (required for Synapse 4 hardware control)

echo.
echo [4/6] Disabling startup programs...
REM Remove Razer programs from startup
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "RzWizard" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Game Manager" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" /v "Razer Game Manager" /f >nul 2>&1
echo - Removed Razer programs from startup

echo.
echo [5/6] Disabling telemetry and updates...
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

REM Disable game-specific features in registry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse3\GameManager" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse3\GameManager" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse4\GameManager" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse4\GameManager" /v "Enabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo - Disabled game manager features

echo.
echo [6/6] Killing running bloatware processes...
taskkill /f /im "Razer Central.exe" >nul 2>&1
taskkill /f /im "RzActionSvc.exe" >nul 2>&1
taskkill /f /im "RazerGameScanner.exe" >nul 2>&1
taskkill /f /im "GameManagerService3.exe" >nul 2>&1
taskkill /f /im "Razer Game Manager Service 3.exe" >nul 2>&1
taskkill /f /im "RazerGameManager.exe" >nul 2>&1
echo - Terminated bloatware processes (including Game Manager)

echo.
echo ================================================
echo                   COMPLETED
echo ================================================
echo.
echo Enhanced changes made:
echo - Disabled Razer Game Scanner Service
echo - Disabled Razer Central Service  
echo - Disabled RzActionSvc
echo - DISABLED Game Manager services (saves ~100MB+ RAM)
echo - Set non-essential services to manual
echo - Kept Synapse Service and RzDeviceEngine enabled
echo - Kept Razer Elevation Service (lightweight)
echo - Preserved RazerAppEngine processes (Synapse 4)
echo - Disabled telemetry and auto-updates
echo - Disabled game-specific features
echo - Removed ALL startup programs
echo.
echo MEMORY SAVINGS: ~100MB+ from disabling Game Manager services
echo.
echo TRADE-OFFS:
echo - No automatic game detection
echo - No per-game lighting profiles
echo - No game-specific macro switching
echo - Manual Synapse launch required
echo.
echo Your device macros and basic functionality will work normally.
echo Reboot recommended to ensure all changes take effect.
echo.
echo To undo these changes, run the restore script.
echo.
pause