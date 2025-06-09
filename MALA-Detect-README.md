Here is a **Markdown-formatted guide** for using **Script 2: Check if logs exist in `C:\mala\C2RLogs`**:

---

# 🔍 How to Check for Existing C2R Logs in `C:\mala\C2RLogs`

This guide describes how to use a PowerShell script to determine whether **Click-to-Run (C2R)** logs already exist on a device. The script checks for `.zip` files in a specific directory and matches the filenames against the current user and computer name.

---

## 📋 What This Script Does

1. Looks in `C:\mala\C2RLogs` for `.zip` log files.
2. Checks if any file contains the **current username and computer name**.
3. Displays a message if a matching log is found.
4. Logs the outcome in `completion.log`.
5. Returns:

   * Exit Code `0` if logs are found.
   * Exit Code `1` if logs are not found.

---

## 📄 Script Breakdown

```powershell
$c2rLogsPath = "C:\mala\C2RLogs"
$username = $env:USERNAME
$computerName = $env:COMPUTERNAME
$completionLog = "C:\mala\completion.log"
```

* Sets the path to search for logs.
* Retrieves the current user's username and computer name.
* Specifies the path to a log file for tracking.

---

```powershell
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
```

* Checks if `C:\mala\C2RLogs` exists.
* Scans for `.zip` files that include the current user's name and computer name.
* If a match is found, sets `$logExists` to `true`.

---

```powershell
Add-Type -AssemblyName System.Windows.Forms
```

* Loads the `System.Windows.Forms` assembly to display a message box.

---

```powershell
if ($logExists) {
    $message = "Logs already exist for $username on $computerName."
    [System.Windows.Forms.MessageBox]::Show($message, "Log Status", 'OK', 'Information')
    Add-Content -Path $completionLog -Value "$(Get-Date) - $message"
    exit 0
} else {
    exit 1
}
```

* If logs exist:

  * Shows a message box to the user.
  * Appends a timestamped message to `completion.log`.
  * Exits with code `0`.
* If not:

  * Exits silently with code `1`.

---

## ▶️ How to Run the Script

1. **Open PowerShell as Administrator**
2. **Paste the script** directly or save it as `CheckLogs.ps1`.
3. **Run it**:

   ```powershell
   .\CheckLogs.ps1
   ```

---

## ✅ Result

* If matching log files are found:

  * A message box appears:
    `"Logs already exist for <username> on <computername>."`
  * The message is saved in `C:\mala\completion.log`.
* If no logs are found:

  * The script exits with code `1`, suitable for chaining in automation.

---

## 🔄 Use Case

This script is ideal as **Step 2 in a chained process**, ensuring logs are only collected if they don’t already exist.

---

By following this guide, you can efficiently determine whether log collection is necessary on a per-device basis.
