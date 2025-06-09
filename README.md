# 🗂️ M365 Apps Log Agent Overview

- **MALA-Download**
  - Downloads the OfficeC2RLogCollector installer from Microsoft.
  - Silently extracts the contents to a temp directory.
  - Creates `C:\mala` if it doesn’t exist.
  - Moves the extracted `.exe` to `C:\mala`.

- **MALA-Detect**
  - Searches `C:\mala\C2RLogs` for `.zip` files.
  - Checks if any file matches the current username and computer name.
  - Displays a message box if logs exist.
  - Logs the result to `completion.log`.
  - Exits with code `0` if logs exist, `1` if not.

- **MALA-Deploy**
  - Verifies that `OfficeC2RLogCollector.exe` is in `C:\mala`.
  - Executes it silently and hidden.
  - Logs the activity to `completion.log`.

- **MALA-Move**
  - Checks for logs in the temp path `C:\Users\<username>\AppData\Local\Temp\C2RLogs`.
  - Moves all log files to `C:\mala\C2RLogs`.
  - Creates the target directory if needed.
  - Deletes the original temp folder if empty.
