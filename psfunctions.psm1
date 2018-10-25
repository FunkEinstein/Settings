# Should be located in %DocumentFolder%\WindowsPowerShall folder by mklink

function change-functions {
    start "C:\Windows\system32\WindowsPowerShell\v1.0\PowerShell_ISE.exe" $PSScriptRoot\psfunctions.psm1
}

function npp { 
    $path = $args[0]

    if ($path) {
        start notepad++ $path
    }
    else {
        start notepad++
    }
}

function en-ru {
    translate -path "https://translate.google.com/#en/ru/" -words $args
}

function ru-en {
    translate -path "https://translate.google.com/#ru/en/" -words $args
}

function translate {
    Param([string]$path,[string[]]$words)

    $text = [string]::Join(" ", $words)
    $fullPath = $path + $text

    start $fullPath
}

function search {
    $path = "https://www.google.com/search?q="
    $query = [string]::Join("+", $args)
    $fullPath = $path + $query

    start $fullPath
}

function open-projects {
    Write-Host " " 
    Write-Host "Listing all visual studio solutions" -ForegroundColor yellow
    Write-Host " " 
    Add-Type @'
    public class solution
    {
        public int id;
        public string name;
        public string fullname;
    }
'@
    $tempSolutions = Get-ChildItem D:\Projects -Recurse -Include *.sln | select Name, FullName 
    $si = New-Object solution
    $st = [Type] $si.GetType()
    $base = [System.Collections.Generic.List``1]
    $qt = $base.MakeGenericType(@($st))
    $so = [Activator]::CreateInstance($qt)
    for($i = 0; $i -lt $tempSolutions.Count; $i++)
    {
        $obj = New-Object solution
        $obj.id = $i
        $obj.name = $tempSolutions[$i].Name
        $obj.fullname = $tempSolutions[$i].FullName
        $so.Add($obj)
    }
    $so | Format-Table -AutoSize
    $choice = Read-Host "Enter a number to open a vs solution or letter x to exit: " 
    if($choice -eq "x"){
        Write-Host -ForegroundColor red "exited selection" -BackgroundColor black
    }
    else
    {
        Write-Host -ForegroundColor Yellow "Opening VS solution:" $so[$choice].name
        Start-Process $so[$choice].fullname
    }
}

function docs {
    start "D:\Documents"
}

function add-path {
    Param([string]$path, [string]$target)
    
    $target = $target.ToLower()
    if ($target -eq "m") { $envVeriableTarget = [EnvironmentVariableTarget]::Machine }
    if ($target -eq "u" -or [string]::IsNullOrEmpty($target)) { $envVeriableTarget = [EnvironmentVariableTarget]::User }

    $newEnvPath = $env:Path + ";" + $path
    [Environment]::SetEnvironmentVariable("Path", $newEnvPath, $envVeriableTarget)
}


function get-path {
    Param([string]$target)
    
    $target = $target.ToLower()
    if ($target -eq "m") { $envVeriableTarget = [EnvironmentVariableTarget]::Machine }
    if ($target -eq "u" -or [string]::IsNullOrEmpty($target)) { $envVeriableTarget = [EnvironmentVariableTarget]::User }

    [Environment]::GetEnvironmentVariable("Path", $envVeriableTarget)
}