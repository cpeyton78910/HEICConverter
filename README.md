# HEICConverter

HEICConverter is a simple PowerShell Script to Automagically Convert HEIC Files to JPEG within the same folder as the file.

## Steps to Set Up

1. Download [Files](https://github.com/cpeyton78910/HEICConverter/archive/refs/heads/main.zip) and Unzip its contents
2. Place `HEICConverter.ps1` into the folder you want monitored
   - Any HEIC files in the same folder as this file will automatically be converted to a JPEG
3. Sometimes, Windows marks downloaded files as unsafe
   1. Right-click `HEICConverter.ps1`
   2. Go to Properties
   3. Check if there’s an "Unblock" checkbox. If so, check it and click Apply
5. Right-click `HEICConverter.ps1` and select **Run with PowerShell**
6. If prompted, click **YES** to run as Administrator
7. After running, the script should start automatically on boot—manual execution shouldn't be necessary

**Important:** Do **NOT** rename `HEICConverter.ps1`, as this **WILL** cause issues

## Steps to Uninstall

1. Run `RemoveHEICConverterFromStartup.bat`
2. If prompted, click **YES** to run as Administrator
3. Delete `HEICConverter.ps1` and `RemoveHEICConverterFromStartup.bat`
4. Navigate to `C:\Program Files`, search for any **ImageMagick** folders, and delete them
