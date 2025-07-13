$baseImageDistro = "Ubuntu-24.04-Base.tar"
$baseDirectoryForTar = Join-Path $PSScriptRoot "base"
$baseImagePath = Join-Path (Join-Path $PSScriptRoot "base") $baseImageDistro
$installPath = Join-Path $PSScriptRoot "distros"
$ubuntuVersion = "Ubuntu-24.04"

Write-Host "Verifying if folders required exists, if they don't exists, they will be created"
try {
    New-Item -ItemType Directory -Path $installPath -Force -ErrorAction Stop | Out-Null
    New-Item -ItemType Directory -Path $baseDirectoryForTar -Force -ErrorAction Stop | Out-Null
} catch {
    Write-Error "CRITICAL ERROR: Failed to create the directories"
    exit 1
}


Write-Host "--- Script Diagnostics ---"
Write-Host "Script Root: $PSScriptRoot"
Write-Host "Expected Full TAR Path: $baseImagePath"
Write-Host "Expected New Distros Root: $installPath"
Write-Host "Expected New Distros Root: $baseDirectoryForTar"
Write-Host "--------------------------`n"
Write-Host "---WSL Creating and exporting base image"
wsl.exe --install $ubuntuVersion
wsl --export $ubuntuVersion $baseImagePath
wsl --unregister $ubuntuVersion


Write-Host "--- WSL Custom Distro Creator ---"
Write-Host "Base image: $baseImageDistro"
Write-Host "Installation directory for the new distros: $installPath`n"

$continueCreating = $true

while ($continueCreating) {
    $newCustomDistroName = Read-Host "Enter the custom name for the new WSL distro"

    if ([string]::IsNullOrWhiteSpace($newCustomDistroName)) {
        Write-Warning "Custom cannot be empty. Please try again."
        continue
    }
    $newCustomDistroNameInstallPath = Join-Path $installPath $newCustomDistroName

    New-Item -ItemType Directory -Path $newCustomDistroNameInstallPath -Force | Out-Null
    Write-Host "Importing '$newCustomDistroName' to '$newCustomDistroNameInstallPath'..."
    wsl.exe --import $newCustomDistroName $newCustomDistroNameInstallPath $baseImagePath --version 2

    $response = Read-Host "Distro '$newCustomDistroName' created. Do you want to create another custom distro? (y/n)"
    if ($response -notmatch '^[yY]$') {
        $continueCreating = $false
    }
    Write-Host "`n"
}

Write-Host "Cleaning up: Deleting the base image TAR file '$baseImagePath'..."
try {
    Remove-Item -Path $baseImagePath -Force -ErrorAction Stop
    Write-Host "  Successfully deleted '$baseImagePath'."
} catch {
    Write-Warning "Failed to delete the base image TAR file '$baseImagePath'. Error: $($_.Exception.Message)"
    Write-Host "You may need to manually delete it."
}

Write-Host "--- All custom distros have been created and base tar image has been deleted"
Write-Host "Listing current distros installed"
wsl.exe -l -v

