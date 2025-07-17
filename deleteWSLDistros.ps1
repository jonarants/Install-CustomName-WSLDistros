$choice
$wslList = wsl -l -v
$wslDistros = @()
Write-Host "Getting current distros installed in WSL"
Write-Host "ITEM  NAME              STATE           VERSION"
$i = 1

foreach ($line in $wslList){
    $cleanline = $line.Trim()
    $cleanline = $cleanline.Replace([string][char]0, "")
    if (($cleanline -notmatch "^\s*NAME\s+STATE\s+VERSION\s*$") -and ($cleanline -ne "")){
        Write-Host "$i   $cleanline"
        $wslDistros += $cleanline -replace '\s+(Stopped|Running)\s+\d+$', ''
        $wslDistros = $wslDistros -replace '^\*\s*', ''
        $i ++
    }
}

$continueAsking = $true
while ($continueAsking){
    $choice = Read-Host "Please select which distro to delete from 1 to $($wslDistros.Count)"
    if ([string]::IsNullOrWhiteSpace($choice)){
        Write-Warning "Choice cannot be empty. Please try again."
        continue
    }
    $choice = [int]$choice

    if ($choice -ge 1 -and $choice -le $wslDistros.Count){
        Write-Host "We will delete de following distro $($wslDistros[$choice-1])"
        $continueAsking = $false
    }
}

$confirmChoice = Read-Host "Are you sure you want to delete $($wslDistros[$choice-1])? (y/n)"

if ($confirmChoice -match '^[yY]$'){
    wsl.exe --unregister $($wslDistros[$choice-1]).Trim()
    Write-Host "Distro $($wslDistros[$choice-1]) has been deleted"
}else {
    Write-Host "Operation aborted"
}

wsl.exe -l -v




