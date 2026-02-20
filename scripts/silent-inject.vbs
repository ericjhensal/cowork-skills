Set objShell = CreateObject("WScript.Shell")
objShell.Run "pwsh.exe -NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File """ & CreateObject("WScript.Shell").ExpandEnvironmentStrings("%USERPROFILE%") & "\Projects\cowork-skills\scripts\auto-inject-skills.ps1""", 0, False
