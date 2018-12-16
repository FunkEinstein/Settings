# add ps-default and ps-local
$isRight = (Read-Host "You want to add ps-default and ps-local? (y/n)").ToLower()
if ($isRight -ne "y") {
    exit
}

$documentsPath = [Environment]::GetFolderPath('MyDocuments');
$powerShellPath = $documentsPath + "\WindowsPowerShell"

# create ps-local
$psLocalPath = $powerShellPath + "\ps-local.psm1"
if (![System.IO.File]::Exists($psLocalPath)) {
    New-Item -Path $psLocalPath -ItemType File
}

# create ps-default
$psDefaultLinkPath = $powerShellPath + "\ps-default.psm1"
$psDefaultOriginalPath = $PSScriptRoot + "\ps-default.psm1"
New-Item -Path $psDefaultLinkPath -ItemType SymbolicLink -Value $psDefaultOriginalPath -Force

# update profile
$psProfilePath = $powerShellPath + "\Microsoft.PowerShell_profile.ps1"
$importLocal = "Import-Module $" + "PSScriptRoot\ps-local.psm1"
$importDefault = "Import-Module $" + "PSScriptRoot\ps-default.psm1"
Write-Output "" | Add-Content -Path $psProfilePath # write new line
Write-Output $importLocal | Add-Content -Path $psProfilePath
Write-Output $importDefault | Add-Content -Path $psProfilePath