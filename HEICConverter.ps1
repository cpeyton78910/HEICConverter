$taskName = "HEICConverterStartup"
$taskFlagPath = "$env:APPDATA\HEICConverterTaskFlag.txt"
$scriptPath = "$PSScriptRoot\HEICConverter.ps1"

# Check if the startup task has already been registered
if (-not (Test-Path $taskFlagPath)) {
    # Request admin ONLY if registering the task
    $identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $princ = New-Object System.Security.Principal.WindowsPrincipal($identity)

    if (-not $princ.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)) {
        Write-Host "Restarting PowerShell as Administrator..."
        Start-Process powershell -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
        exit
    }

    Write-Host "Adding script to startup..."
    $action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
    $trigger = New-ScheduledTaskTrigger -AtStartup
    $principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -LogonType ServiceAccount
    $task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal
    Register-ScheduledTask -TaskName $taskName -InputObject $task

    # Save flag to prevent future admin prompts
    New-Item -ItemType File -Path $taskFlagPath -Force
    Write-Host "Startup task created!"
} else {
    Write-Host "Startup task already exists. No admin prompt needed."
}

# Check if ImageMagick is installed
$magickPath = Get-Command magick.exe -ErrorAction SilentlyContinue

if (-not $magickPath) {
    Write-Host "ImageMagick not found. Installing now..."
    Invoke-WebRequest -Uri "https://imagemagick.org/archive/binaries/ImageMagick-7.1.1-47-Q16-HDRI-x64-dll.exe" -OutFile "$env:TEMP\ImageMagickInstaller.exe"
    Start-Process -FilePath "$env:TEMP\ImageMagickInstaller.exe" -ArgumentList "/silent" -Wait
    Write-Host "ImageMagick installed successfully!"
    Start-Process powershell -ArgumentList "-NoExit -File `"$PSCommandPath`""
    exit
}

# Minimize Current PowerShell Window
Add-Type @"
using System;
using System.Runtime.InteropServices;
public class WinAPI {
    [DllImport("user32.dll")]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    [DllImport("kernel32.dll")]
    public static extern IntPtr GetConsoleWindow();
}
"@
[WinAPI]::ShowWindow([WinAPI]::GetConsoleWindow(), 6)

$folderPath = $PSScriptRoot

# Convert and Delete Existing HEIC Files
Get-ChildItem -Path $folderPath -Filter "*.heic" | ForEach-Object {
    $newName = $_.FullName -replace "\.heic$", ".jpeg"
    Start-Process -FilePath "magick.exe" -ArgumentList "`"$($_.FullName)`" `"$newName`"" -NoNewWindow -Wait
    Write-Host "Converted: $_ -> $newName"
    Remove-Item $_.FullName -Force  # Delete original HEIC file
    Write-Host "Deleted original: $_"
}

# Monitor Folder for New HEIC Files
$watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = $folderPath
$watcher.Filter = "*.heic"
$watcher.EnableRaisingEvents = $true

$action = {
    Get-ChildItem -Path $folderPath -Filter "*.heic" | ForEach-Object {
        $newName = $_.FullName -replace "\.heic$", ".jpeg"
        Start-Process -FilePath "magick.exe" -ArgumentList "`"$($_.FullName)`" `"$newName`"" -NoNewWindow -Wait
        Write-Host "Converted: $_ -> $newName"
        Remove-Item $_.FullName -Force  # Delete original HEIC file
        Write-Host "Deleted original: $_"
    }
}

Register-ObjectEvent -InputObject $watcher -EventName "Created" -Action $action

Write-Host "All existing HEIC files converted and deleted. Now monitoring folder: $folderPath for new HEIC files... Press Ctrl+C to stop."
while ($true) { Start-Sleep 1 }