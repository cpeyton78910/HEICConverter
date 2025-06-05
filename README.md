# HEICConverter

HEICConverter is a simple PowerShell Script to Automagically Convert HEIC Files to JPEG within the same folder as the file.  
This program is designed so you only have to run it once, then it will start automatically on boot.

## Steps to Set Up

1. Download [Files](https://github.com/cpeyton78910/HEICConverter/archive/refs/heads/main.zip) and extract its contents
2. Place `HEICConverter.ps1` into the folder you want monitored
   - Any HEIC files in the same folder as this file will automatically be converted to a JPEG
3. Right-click `HEICConverter.ps1` and select **Run with PowerShell**
4. If prompted, click **YES** to run as Administrator
5. After running once, the script will automatically launch on startup—no need for manual execution.
   - If the program closes immediately and does not appear to work, follow the steps in the 'Handling OS Security' section

**Important:** Do **NOT** rename `HEICConverter.ps1`, as this **WILL** cause issues.  
If the script was placed then executed from the wrong folder:
1. Run `RemoveHEICConverterFromStartup.bat`
2. If prompted, click **YES** to run as Administrator
3. Then repeat steps 3-5

## Handling OS Security
Your OS may block downloaded scripts from the Internet for security reasons. If that happens:
1. Right-click `HEICConverter.ps1`
2. Go to Properties
3. Look for an 'Unblock' checkbox, check it, and click Apply. After applying the change, continue with Step 3

## Steps to Uninstall

1. Run `RemoveHEICConverterFromStartup.bat`
2. If prompted, click **YES** to run as Administrator, then let the program run
3. Delete `HEICConverter.ps1` and `RemoveHEICConverterFromStartup.bat`
4. Navigate to `C:\Program Files`, locate any ImageMagick folders, and delete them
