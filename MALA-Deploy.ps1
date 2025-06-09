# Script 3: Run OfficeC2RLogCollector if logs don't exist

$malaPath = "C:\mala"
$exePath = Join-Path $malaPath "OfficeC2RLogCollector.exe"
$completionLog = "$malaPath\completion.log"
$username = $env:USERNAME
$computerName = $env:COMPUTERNAME

# Run the collector silently and hide command prompt
if (Test-Path $exePath) {
    $arguments = "/silent"
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $exePath
    $startInfo.Arguments = $arguments
    $startInfo.WindowStyle = 'Hidden'
    $startInfo.UseShellExecute = $true

    $process = [System.Diagnostics.Process]::Start($startInfo)
    $process.WaitForExit()

    # Write to completion log
    Add-Content -Path $completionLog -Value "$(Get-Date) - Log collection initiated for $username on $computerName."
} else {
    Write-Error "Log collector executable not found at $exePath"
}
