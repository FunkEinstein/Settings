$userName = $args[0]

if (!$userName) {
    "Pass user name into script!"
    exit
}

# pathes to .gitconfig
$gitConfigLinkPath = "C:\Users\" + $userName + "\.gitconfig"
$gitConfigOriginalPath = $PSScriptRoot + "\.gitconfig"

# pathes to GlobalSettingsStorage.DotSettings
$resharperSettingsLinkPath = "C:\Users\" + $userName + "\AppData\Roaming\JetBrains\Shared\vAny\GlobalSettingsStorage.DotSettings"
$resharperSettingsOriginalPath = $PSScriptRoot + "\GlobalSettingsStorage.DotSettings"

# pathes to ConEmu.xml
$conemuSettingsLinkPath = "C:\Users\" + $userName + "\AppData\Roaming\ConEmu.xml"
$conemuSettingsOriginalPath = $PSScriptRoot + "\ConEmu.xml"

Write-Host $gitConfigLinkPath "<==>" $gitConfigOriginalPath
Write-Host $resharperSettingsLinkPath "<==>" $resharperSettingsOriginalPath
Write-Host $conemuSettingsLinkPath "<==>" $conemuSettingsOriginalPath

$isRight = (Read-Host "Check pathes, is they right? (y/n)").ToLower()
if ($isRight -ne "y") {
    exit
}

# create link to .gitconfig
if ([System.IO.File]::Exists($gitConfigLinkPath)) {
    Remove-Item -Path $gitConfigLinkPath
}

New-Item -Path $gitConfigLinkPath -ItemType SymbolicLink -Value $gitConfigOriginalPath -Force

# create link to GlobalSettingsStorage.DotSettings
if ([System.IO.File]::Exists($resharperSettingsLinkPath)) {
    Remove-Item -Path $resharperSettingsLinkPath
}

New-Item -Path $resharperSettingsLinkPath -ItemType SymbolicLink -Value $resharperSettingsOriginalPath -Force

# create link to ConEmu.xml
if ([System.IO.File]::Exists($conemuSettingsLinkPath)) {
    Remove-Item -Path $conemuSettingsLinkPath
}

New-Item -Path $conemuSettingsLinkPath -ItemType SymbolicLink -Value $conemuSettingsOriginalPath -Force