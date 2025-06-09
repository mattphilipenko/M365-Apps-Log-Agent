Here's a **Markdown-formatted "How-To" article** for the script you provided:

---

# 🛠️ How to Run OfficeC2RLogCollector Silently if Logs Don’t Exist

This guide walks you through running the `OfficeC2RLogCollector.exe` tool silently using PowerShell—**only if the executable exists in the specified directory**. The script ensures a minimal user experience by hiding the command prompt and logs completion status.

---

## 📁 Prerequisites

* Ensure the `OfficeC2RLogCollector.exe` file is placed in `C:\mala`.
* Confirm PowerShell execution policies allow script execution (`Set-ExecutionPolicy` may be required).
* The script is designed for Windows environments with administrative privileges if needed.

---

## 📄 Script Purpose

This PowerShell script performs the following:

1. Checks if the Office C2R Log Collector executable exists.
2. Runs it silently and hidden.
3. Logs the collection activity to `completion.log` for tracking.

---

## 🧾 Script Explained

```powershell
$malaPath = "C:\mala"
$exePath = Join-Path $malaPath "OfficeC2RLogCollector.exe"
$completionLog = "$malaPath\completion.log"
$username = $env:USERNAME
$computerName = $env:COMPUTERNAME
```

* Sets the path where the collector is expected.
* Retrieves current username and machine name.
* Defines the log file path.

---

```powershell
if (Test-Path $exePath) {
```

* Checks if the collector exists.

---

```powershell
    $arguments = "/silent"
    $startInfo = New-Object System.Diagnostics.ProcessStartInfo
    $startInfo.FileName = $exePath
    $startInfo.Arguments = $arguments
    $startInfo.WindowStyle = 'Hidden'
    $startInfo.UseShellExecute = $true
```

* Configures the process to run silently and hidden.

---

```powershell
    $process = [System.Diagnostics.Process]::Start($startInfo)
    $process.WaitForExit()
```

* Launches the process and waits until it finishes.

---

```powershell
    Add-Content -Path $completionLog -Value "$(Get-Date) - Log collection initiated for $username on $computerName."
```

* Appends a log entry with a timestamp and user/computer info.

---

```powershell
} else {
    Write-Error "Log collector executable not found at $exePath"
}
```

* Displays an error if the executable is missing.

---

## ✅ What You'll See

* No window will appear (runs hidden).
* A log entry will be created in `C:\mala\completion.log`.
* Errors are shown only if the collector is not found.

---

## 🔒 Pro Tip: Run as Administrator

To ensure full access to file paths and system-level execution, **right-click PowerShell and choose "Run as Administrator."**

---

By following this approach, you can automate log collection discreetly and efficiently across multiple machines or during software support workflows.
