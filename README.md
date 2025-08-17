# Roblox Shortcut Remover 🚀

Roblox creates two desktop shortcuts **every time it updates**:

- `Roblox Player.lnk`  
- `Roblox Studio.lnk`  

There is no official way to stop this.  
If you like to keep your desktop clean, this gets frustrating quickly.  

This tool fixes that.  

---

## 🔧 What it does

- Deletes `Roblox Player.lnk` and `Roblox Studio.lnk`  
- Cleans both your **user Desktop** and the shared **Public Desktop**  
- Runs **every minute** in the background  
- Works silently (no PowerShell window flicker)  
- Compatible with **Windows 10 / 11**  

---

## 📥 Installation

Run this command in **PowerShell (Run as Administrator):**

```powershell
irm https://raw.githubusercontent.com/iron-panther/roblox-cleaner/main/install.ps1 | iex
```

## 🗑 Uninstall

To remove the scheduled task and scripts completely, Run this command in **PowerShell (Run as Administrator):**

```powershell
irm https://raw.githubusercontent.com/iron-panther/roblox-cleaner/main/uninstall.ps1 | iex
