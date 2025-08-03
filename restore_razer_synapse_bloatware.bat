@echo off
echo ================================================
echo   Enhanced Razer Synapse 3/4 Restoration Script
echo ================================================
echo.
echo This script will restore ALL Razer services to their
echo default settings, including Game Manager services.
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
echo [1/5] Re-enabling all Razer services...

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

echo.
echo [2/5] Restoring Game Manager services...

REM Re-enable the Game Manager services
sc config "Razer Game Manager Service" start= auto >nul 2>&1
sc start "Razer Game Manager Service" >nul 2>&1
echo - Re-enabled Razer Game Manager Service

sc config "GameManagerService3" start= auto >nul 2>&1
sc start "GameManagerService3" >nul 2>&1
echo - Re-enabled GameManagerService3

sc config "RazerIngameEngine" start= auto >nul 2>&1
echo - Set RazerIngameEngine to automatic startup

sc config "RzKLService" start= auto >nul 2>&1
echo - Set RzKLService to automatic startup

echo.
echo [3/5] Ensuring essential services are running...

sc config "Razer Synapse Service" start= auto >nul 2>&1
sc start "Razer Synapse Service" >nul 2>&1
echo - Ensured Razer Synapse Service is running

sc config "RzDeviceEngine" start= auto >nul 2>&1
sc start "RzDeviceEngine" >nul 2>&1
echo - Ensured RzDeviceEngine is running

sc config "Razer Elevation Service" start= auto >nul 2>&1
sc start "Razer Elevation Service" >nul 2>&1
echo - Ensured Razer Elevation Service is running

echo.
echo [4/5] Restoring startup programs and settings...

REM Restore Razer Central to startup (if it exists)
if exist "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Central" /t REG_SZ /d "\"%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe\" --silent" /f >nul 2>&1
    echo - Restored Razer Central to startup
)

REM Restore Game Manager to startup if it exists
if exist "%ProgramFiles(x86)%\Razer\RazerGameManager\RazerGameManager.exe" (
    reg add "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run" /v "Razer Game Manager" /t REG_SZ /d "\"%ProgramFiles(x86)%\Razer\RazerGameManager\RazerGameManager.exe\"" /f >nul 2>&1
    echo - Restored Razer Game Manager to startup
)

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

REM Re-enable game-specific features in registry
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse3\GameManager" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse3\GameManager" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_LOCAL_MACHINE\SOFTWARE\Razer\Synapse4\GameManager" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Razer\Synapse4\GameManager" /v "Enabled" /t REG_DWORD /d 1 /f >nul 2>&1
echo - Re-enabled game manager features

echo.
echo [5/5] Starting Razer applications...

REM Start Razer Central if it exists
if exist "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" (
    start "" "%ProgramFiles(x86)%\Razer\Razer Central\Razer Central.exe" --silent
    echo - Started Razer Central
)

REM Start Game Manager if it exists
if exist "%ProgramFiles(x86)%\Razer\RazerGameManager\RazerGameManager.exe" (
    start "" "%ProgramFiles(x86)%\Razer\RazerGameManager\RazerGameManager.exe"
    echo - Started Razer Game Manager
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
echo - Re-enabled ALL Razer services (including Game Manager)
echo - Restored startup programs (Central + Game Manager)
echo - Re-enabled telemetry and updates
echo - Re-enabled game-specific features
echo - Started all Razer applications
echo.
echo RESTORED FEATURES:
echo - Automatic game detection
echo - Per-game lighting profiles
echo - Game-specific macro switching
echo - All overlay and enhancement features
echo.
echo Your Razer software is now back to its original bloated state.
echo All features including macros, RGB, Game Manager, and updates are active.
echo Memory usage will return to ~100MB+ for Game Manager services.
echo.
pause