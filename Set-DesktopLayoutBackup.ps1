function Test-ReparsePoint([string]$path) {
    $file = Get-Item $path -Force -ea SilentlyContinue
    return [bool]($file.Attributes -band [IO.FileAttributes]::ReparsePoint)
}

$localsig = "$env:APPDATA\DesktopOK\"
$ODSig = "$ENV:OneDriveCommercial\DesktopOK\"
if((Test-ReparsePoint -path $localsig) -eq $true) {
    Write-Host "Nothing To Do"
} else {
   if((Test-Path -Path $ODSIg) -eq $false) {
       Write-Host need to make the folder
       New-Item -ItemType Folder -Path $ODSig
       }
Get-ChildItem -Path $localsig | Copy-Item -Destination $ODSig -Container -Recurse -Force
Rename-Item -Path $localsig -NewName "$localsig\DesktopOK.bak"
$CommandList = "`"New-Item -ItemType SymbolicLink -Path '" + $localsig + "' -Target `'" + $ODSig + "`'"
#$CommandList = Read-Host -Prompt "HI"
Start-Process -FilePath PowerShell.exe -Verb RunAs -ArgumentList $CommandList

}

