# Quick sync: push local skill changes to GitHub
Set-Location "$env:USERPROFILE\Projects\cowork-skills"
git add -A
$msg = "Sync skills - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $msg
git push origin main
Write-Host "Skills synced to GitHub." -ForegroundColor Green
