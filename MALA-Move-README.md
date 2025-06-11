---

# 📦 How to Move Office C2R Logs from Temp to `C:\mala\C2RLogs`

This guide explains how to use a PowerShell script to **relocate Office Click-to-Run (C2R) logs** from the temporary directory to a permanent location at `C:\mala\C2RLogs`.

---

## 📋 Purpose

The script checks for the existence of the `C2RLogs` folder in the user's temp directory and moves its contents to `C:\mala\C2RLogs`. This ensures logs are stored in a consistent and accessible location.

---

## 🧾 Script Breakdown

```powershell
$tempLogPath = Join-Path $env:USERPROFILE "AppData\Local\Temp\C2RLogs"
$destinationPath = "C:\mala"
```

* Defines the source and target directories using the current user's profile.

---

```powershell
if (Test-Path $tempLogPath) {
```

* Checks if the temp log folder exists before proceeding.

---

```powershell
    $targetPath = Join-Path $destinationPath "C2RLogs"

    # Create destination C2RLogs folder if it doesn't exist
    if (!(Test-Path $targetPath)) {
        New-Item -Path $targetPath -ItemType Directory | Out-Null
    }
```

* Constructs the full target path.
* Ensures the destination folder (`C:\mala\C2RLogs`) exists.

---

```powershell
    # Move log files to C:\mala\C2RLogs
    Get-ChildItem -Path $tempLogPath -File | ForEach-Object {
        Move-Item -Path $_.FullName -Destination $targetPath -Force
    }
```

* Moves all files from the temp folder to the target location.
* Overwrites any existing files with the same name.

---

```powershell
    # Optionally remove the original folder if empty
    if ((Get-ChildItem -Path $tempLogPath).Count -eq 0) {
        Remove-Item -Path $tempLogPath -Force
    }
}
```

* Cleans up the temp folder if it's empty after moving the files.

---

## ▶️ How to Use the Script

1. **Open PowerShell as Administrator**
2. **Run the script** by pasting it into PowerShell or saving it as a `.ps1` file:

   ```powershell
   .\MoveC2RLogs.ps1
   ```

---

## ✅ Outcome

* Log files from `C:\Users\<YourName>\AppData\Local\Temp\C2RLogs` are moved to:

  ```
  C:\mala\C2RLogs
  ```
* Temporary log files are consolidated into a permanent storage location.

---

## 🔐 Notes

* Make sure `C:\mala` is writable by the script or user.
* If you’re automating across multiple machines, dynamically resolve the user profile path using `$env:USERPROFILE`:

  ```powershell
  $tempLogPath = Join-Path $env:USERPROFILE "AppData\Local\Temp\C2RLogs"
  ```

---

By using this script, you ensure C2R logs are gathered in a central and consistent location, improving manageability and log accessibility for troubleshooting.
