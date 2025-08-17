$ErrorActionPreference = 'SilentlyContinue'

Write-Host "=== Installing Roblox shortcut remover (silent) ===`n"

$toolsDir   = "C:\Tools"
$psScript   = Join-Path $toolsDir "Remove-RobloxShortcuts.ps1"
$vbsWrapper = Join-Path $toolsDir "Remove-RobloxShortcuts.vbs"

if (-not (Test-Path $toolsDir)) {
    New-Item -Path $toolsDir -ItemType Directory | Out-Null
}

@'
$ErrorActionPreference = "SilentlyContinue"

$userDesktop   = [Environment]::GetFolderPath("Desktop")
$publicDesktop = Join-Path $env:PUBLIC "Desktop"
$desktops      = @($userDesktop, $publicDesktop)

$targets = @("Roblox Player.lnk","Roblox Studio.lnk")

foreach ($desk in $desktops) {
  foreach ($name in $targets) {
    $p = Join-Path $desk $name
    if (Test-Path $p) { Remove-Item -LiteralPath $p -Force -ErrorAction SilentlyContinue }
  }
}
'@ | Set-Content -Path $psScript -Encoding UTF8

@'
Set objShell = CreateObject("Wscript.Shell")
objShell.Run "powershell.exe -NoProfile -ExecutionPolicy Bypass -File ""C:\Tools\Remove-RobloxShortcuts.ps1""", 0, False
'@ | Set-Content -Path $vbsWrapper -Encoding ASCII

schtasks /Delete /TN "Remove Roblox Shortcuts (1min)" /F >$null 2>&1

$action   = New-ScheduledTaskAction -Execute "wscript.exe" -Argument "`"$vbsWrapper`""
$trigger  = New-ScheduledTaskTrigger -Once -At (Get-Date).AddMinutes(1) `
             -RepetitionInterval (New-TimeSpan -Minutes 1) `
             -RepetitionDuration (New-TimeSpan -Days 9999)
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -StartWhenAvailable -MultipleInstances IgnoreNew

Register-ScheduledTask -TaskName "Remove Roblox Shortcuts (1min)" `
  -Action $action -Trigger $trigger -Settings $settings -RunLevel Highest `
  -Description "Deletes Roblox Player/Studio shortcuts silently every minute"

Write-Host "`n[OK] Roblox shortcut remover installed."
