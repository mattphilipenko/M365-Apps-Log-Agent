---

# 🧰 How to Download and Extract the Office C2R Log Collector to `C:\mala`

This guide explains how to use a PowerShell script to download the Microsoft Office Click-to-Run (C2R) Log Collector tool, extract it, and move the main executable to a specified directory (`C:\mala`).

---

## 📋 Overview

The script performs the following actions:

1. Downloads the `officedeploymentlogcollector.exe` installer from Microsoft.
2. Extracts the contents silently to a temporary location.
3. Creates a `C:\mala` directory if it doesn’t exist.
4. Moves the `OfficeC2RLogCollector.exe` file to the `C:\mala` directory.

---

## 📄 Script Breakdown

```powershell
# Define variables
$downloadUrl = "https://download.microsoft.com/download/2/d/9/2d9f7837-c440-42ca-86f8-9d46cd332c8c/officedeploymentlogcollector.exe"
$downloadPath = "$env:TEMP\officedeploymentlogcollector.exe"
$extractPath = "$env:TEMP\OfficeC2RExtracted"
$malaPath = "C:\mala"
$extractedExeName = "OfficeC2RLogCollector.exe"
```

These variables set the download URL, temporary storage location, and final destination for the extracted `.exe`.

---

```powershell
# Download the EXE
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath
```

Downloads the log collector installer from Microsoft to the user's temp folder.

---

```powershell
# Extract to temp location
Start-Process -FilePath $downloadPath -ArgumentList "/quiet /extract:$extractPath" -Wait
```

Silently extracts the self-extracting archive to a temporary folder.

---

```powershell
# Ensure mala directory exists
if (!(Test-Path -Path $malaPath)) {
    New-Item -Path $malaPath -ItemType Directory | Out-Null
}
```

Checks if `C:\mala` exists. If not, it creates the folder.

---

```powershell
# Move extracted EXE to mala directory
Move-Item -Path (Join-Path $extractPath $extractedExeName) -Destination $malaPath -Force
```

Moves the actual `OfficeC2RLogCollector.exe` file to `C:\mala`, overwriting any existing file.

---

## ⚙️ How to Run the Script

1. **Open PowerShell as Administrator**

   * Press `Windows` key → search for `PowerShell` → Right-click → **Run as Administrator**

2. **Paste the script and press Enter**

   * Or save it as `DownloadCollector.ps1` and run it with:

     ```powershell
     .\DownloadCollector.ps1
     ```

---

## ✅ Outcome

* `OfficeC2RLogCollector.exe` will be placed in:
  `C:\mala`

* Ready for use in further automation or manual execution.

---

## 🔐 Notes

* Make sure your system allows downloads via `Invoke-WebRequest`.
* Internet connection is required.
* This script avoids any GUI interaction by using silent extraction.

---

With this guide, you can quickly prepare your environment for Office log collection using Microsoft’s official tool.



