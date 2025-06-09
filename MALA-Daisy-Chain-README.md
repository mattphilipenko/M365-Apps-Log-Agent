1. **MALA-Download** – Downloads and extracts the log collector to `C:\mala`.
2. **MALA-Detect** – Checks for existing logs and exits with `0` if found, `1` if not.
3. **MALA-Deploy** – Executes the log collector only if needed.
4. **MALA-Move** - Moves the log files from the Temp location to C:\mala\C2RLogs

You can chain them in PowerShell like this:

```powershell
.\MALA-Download.ps1
if ($LASTEXITCODE -ne 0) {
    .\MALA-Detect.ps1
    if ($LASTEXITCODE -ne 0) {
        .\MALA-Deploy.ps1
    }
}
```

Let me know if you'd like a master script to coordinate the chaining.
