# Script 2: Check if logs exist in C:\mala\C2RLogs

$c2rLogsPath = "C:\mala\C2RLogs"
$username = $env:USERNAME
$computerName = $env:COMPUTERNAME
$completionLog = "C:\mala\completion.log"

$logExists = $false
if (Test-Path $c2rLogsPath) {
    $zipFiles = Get-ChildItem -Path $c2rLogsPath -Filter "*.zip" -File
    foreach ($zip in $zipFiles) {
        if ($zip.Name -like "*$username*$computerName*") {
            $logExists = $true
            break
        }
    }
}

# Output result and write to log
Add-Type -AssemblyName System.Windows.Forms
if ($logExists) {
    $message = "Logs already exist for $username on $computerName."
    [System.Windows.Forms.MessageBox]::Show($message, "Log Status", 'OK', 'Information')
    Add-Content -Path $completionLog -Value "$(Get-Date) - $message"
    exit 0
} else {
    exit 1
}

