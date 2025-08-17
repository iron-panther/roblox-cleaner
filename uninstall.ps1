schtasks /Delete /TN "Remove Roblox Shortcuts (1min)" /F >$null 2>&1
Remove-Item "C:\Tools\Remove-RobloxShortcuts.ps1" -Force -ErrorAction SilentlyContinue
Remove-Item "C:\Tools\Remove-RobloxShortcuts.vbs" -Force -ErrorAction SilentlyContinue
Write-Host "[OK] Roblox shortcut remover uninstalled."
