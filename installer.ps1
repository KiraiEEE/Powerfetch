# install.ps1

# Specify the URL of the .ps1 file and the destination folder
$sourceUrl = "https://raw.githubusercontent.com/jantari/powerfetch/master/powerfetch.ps1"
$destinationFolder = Join-Path $env:APPDATA "pfetch"
$destinationFilePath = Join-Path $destinationFolder "powerfetch.ps1"

# Create the destination folder if it doesn't exist
if (-not (Test-Path -Path $destinationFolder -PathType Container)) {
    New-Item -ItemType Directory -Path $destinationFolder | Out-Null
}

# Download the .ps1 file from the URL
Invoke-WebRequest -Uri $sourceUrl -OutFile $destinationFilePath

# Add the destination folder to the user's PATH variable
$existingPath = [System.Environment]::GetEnvironmentVariable("PATH", [System.EnvironmentVariableTarget]::User)
if ($existingPath -notlike "*$destinationFolder*") {
    $newPath = $existingPath + ";$destinationFolder"
    [System.Environment]::SetEnvironmentVariable("PATH", $newPath, [System.EnvironmentVariableTarget]::User)
    Write-Host "Folder added to PATH: $destinationFolder"
} else {
    Write-Host "Folder already in PATH: $destinationFolder"
}

Write-Host "Installation complete."
