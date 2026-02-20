# ============================================
# INSTALL AUTO-INJECT AS WINDOWS SCHEDULED TASK
# Run this once. It creates a task that checks
# every 2 minutes for new Cowork sessions and
# injects your skills automatically.
# ============================================

$taskName = "CoworkSkillsAutoInject"
$scriptPath = "$env:USERPROFILE\Projects\cowork-skills\scripts\auto-inject-skills.ps1"

# Remove existing task if present
$existing = Get-ScheduledTask -TaskName $taskName -ErrorAction SilentlyContinue
if ($existing) {
    Unregister-ScheduledTask -TaskName $taskName -Confirm:$false
    Write-Host "[OK] Removed existing scheduled task." -ForegroundColor Yellow
}

# Create the action
$action = New-ScheduledTaskAction `
    -Execute "pwsh.exe" `
    -Argument "-NoProfile -WindowStyle Hidden -ExecutionPolicy Bypass -File `"$scriptPath`""

# Trigger: every 2 minutes, indefinitely
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 2)

# Settings: run whether logged in or not, don't stop if on battery
$settings = New-ScheduledTaskSettingsSet `
    -AllowStartIfOnBatteries `
    -DontStopIfGoingOnBatteries `
    -StartWhenAvailable `
    -ExecutionTimeLimit (New-TimeSpan -Minutes 1) `
    -MultipleInstances IgnoreNew

# Register the task
Register-ScheduledTask `
    -TaskName $taskName `
    -Action $action `
    -Trigger $trigger `
    -Settings $settings `
    -Description "Auto-injects custom skills into new Cowork sessions from GitHub repo" `
    -RunLevel Limited

Write-Host ""
Write-Host "=== INSTALLED ===" -ForegroundColor Green
Write-Host "Task name: $taskName" -ForegroundColor Cyan
Write-Host "Runs every: 2 minutes" -ForegroundColor Cyan
Write-Host "Script: $scriptPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your custom skills will now auto-load into every new Cowork session." -ForegroundColor Green
Write-Host "No need to type anything. Just start Cowork and they'll be there." -ForegroundColor Green
Write-Host ""
Write-Host "To check status:  Get-ScheduledTask -TaskName '$taskName'" -ForegroundColor Gray
Write-Host "To remove:        Unregister-ScheduledTask -TaskName '$taskName'" -ForegroundColor Gray
Write-Host "To view log:      Get-Content '$env:USERPROFILE\Projects\cowork-skills\inject-log.txt' -Tail 20" -ForegroundColor Gray
