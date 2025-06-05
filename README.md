# HEICConverter

HEICConverter is a simple PowerShell Script to Automagically Convert HEIC Files to JPEG within the same folder as the file.

## Steps to Set Up

1. Place `HEICConverter.ps1` into the folder you want monitored
   - Any HEIC files in the same folder as this file will automatically be converted to a JPEG
2. Right-click `HEICConverter.ps1` and select **Run with PowerShell**
3. If prompted, click **YES** to run as Administrator
4. After running, the script should start automatically on boot—manual execution shouldn't be necessary

**Important:** Do **NOT** rename `HEICConverter.ps1`, as this **WILL** cause issues.

## Steps to Uninstall

1. Run `RemoveHEICConverterFromStartup.bat`
2. If prompted, click **YES** to run as Administrator
3. Delete `HEICConverter.ps1` and `RemoveHEICConverterFromStartup.bat`
4. Navigate to `C:\Program Files`, search for any **ImageMagick** folders, and delete them
