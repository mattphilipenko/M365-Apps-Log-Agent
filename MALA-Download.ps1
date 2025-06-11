# Script 1: Download the log collector and place it in C:\mala

# Define variables
$downloadUrl = "https://download.microsoft.com/download/2/d/9/2d9f7837-c440-42ca-86f8-9d46cd332c8c/officedeploymentlogcollector.exe"
$downloadPath = "$env:TEMP\officedeploymentlogcollector.exe"
$extractPath = "$env:TEMP\OfficeC2RExtracted"
$malaPath = "C:\mala"
$extractedExeName = "OfficeC2RLogCollector.exe"

# Download the EXE
Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath

# Extract to temp location
Start-Process -FilePath $downloadPath -ArgumentList "/quiet /extract:$extractPath" -Wait

# Ensure mala directory exists
if (!(Test-Path -Path $malaPath)) {
    New-Item -Path $malaPath -ItemType Directory | Out-Null
}

# Move extracted EXE to mala directory
Move-Item -Path (Join-Path $extractPath $extractedExeName) -Destination $malaPath -Force
