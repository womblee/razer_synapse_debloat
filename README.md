# Remove Razer Synapse 3/4 Bloatware
A set of scripts to debloat/restore Razer Synapse software without breaking functionality.

TL-DR:
- Run `disable_razer_synapse_bloatware.bat` as admin, reboot, enjoy.

## What it does
*Removes:*
- `Razer Game Scanner Service` (game detection bloatware)
- `Razer Central Service` (store/ecosystem app)
- `RzActionSvc` (overlay features)
- Automatic updates and telemetry
- Startup programs and background processes

*Keeps:*
- Mouse/keyboard macros (fully functional)
- Device profiles and settings
- Hardware communication (RzDeviceEngine)
- Core Synapse functionality

## How to use
### Quick Start

Download both scripts from this repository
1. Right-click `disable_razer_synapse_bloatware.bat` → "Run as administrator"
2. Reboot your computer
3. Test your mouse functionality

### Restore Functionality

To restore the full functionality of Razer Synapse, you must run `restore_razer_synapse_bloatware.bat`, which is also included in this repository.

## Script in action
<img width="679" height="130" alt="image" src="https://github.com/user-attachments/assets/421e9749-bd1f-48a0-a19b-b0df49663ac2" />

After running the script, these are the services and processes that are still running.

### Before
**~500-800MB** RAM usage, constant background activity

### After
**~365MB** RAM usage, faster boot, no bloatware processes
