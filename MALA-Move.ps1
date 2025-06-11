# Script 4: Move C2RLogs from temp to C:\mala

$tempLogPath = Join-Path $env:USERPROFILE "AppData\Local\Temp\C2RLogs"
$destinationPath = "C:\mala"

if (Test-Path $tempLogPath) {
    $targetPath = Join-Path $destinationPath "C2RLogs"

    # Create destination C2RLogs folder if it doesn't exist
    if (!(Test-Path $targetPath)) {
        New-Item -Path $targetPath -ItemType Directory | Out-Null
    }

    # Move log files to C:\mala\C2RLogs
    Get-ChildItem -Path $tempLogPath -File | ForEach-Object {
        Move-Item -Path $_.FullName -Destination $targetPath -Force
    }

    # Optionally remove the original folder if empty
    if ((Get-ChildItem -Path $tempLogPath).Count -eq 0) {
        Remove-Item -Path $tempLogPath -Force
    }
}
