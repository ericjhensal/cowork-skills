# ============================================
# COWORK SKILLS SETUP SCRIPT FOR FOUCAULT
# Run this once to create the GitHub repo
# and establish the persistent skills pipeline.
# ============================================

$ErrorActionPreference = "Stop"
$repoName = "cowork-skills"
$repoPath = "$env:USERPROFILE\Projects\$repoName"

Write-Host "=== Cowork Skills Setup ===" -ForegroundColor Cyan
Write-Host ""

# Step 1: Create local directory
if (Test-Path $repoPath) {
    Write-Host "[OK] Directory already exists: $repoPath" -ForegroundColor Green
} else {
    Write-Host "[+] Creating directory: $repoPath" -ForegroundColor Yellow
    New-Item -ItemType Directory -Path $repoPath -Force | Out-Null
}

# Step 2: Find the skills source (from Cowork outputs)
$outputsBase = "$env:APPDATA\Claude\local-agent-mode-sessions"
$skillsSource = $null

# Search for the most recent outputs folder with cowork-skills
$outputFolders = Get-ChildItem -Path $outputsBase -Recurse -Directory -Filter "cowork-skills" -ErrorAction SilentlyContinue |
    Sort-Object LastWriteTime -Descending

if ($outputFolders.Count -gt 0) {
    $skillsSource = $outputFolders[0].FullName
    Write-Host "[OK] Found skills source: $skillsSource" -ForegroundColor Green
} else {
    Write-Host "[!] No cowork-skills found in Cowork outputs." -ForegroundColor Red
    Write-Host "    Make sure you've run a Cowork session that created the skills first." -ForegroundColor Red
    exit 1
}

# Step 3: Copy skills to the local repo directory
Write-Host "[+] Copying skills to $repoPath ..." -ForegroundColor Yellow
Copy-Item -Path "$skillsSource\*" -Destination $repoPath -Recurse -Force
Write-Host "[OK] Skills copied." -ForegroundColor Green

# Step 4: Initialize git repo
Set-Location $repoPath
if (Test-Path ".git") {
    Write-Host "[OK] Git repo already initialized." -ForegroundColor Green
} else {
    Write-Host "[+] Initializing git repo..." -ForegroundColor Yellow
    git init
    git branch -M main
}

# Step 5: Create .gitignore
$gitignore = @"
__pycache__/
*.pyc
.DS_Store
Thumbs.db
"@
Set-Content -Path ".gitignore" -Value $gitignore

# Step 6: Create README
$readme = @"
# Cowork Skills for FOUCAULT

Persistent custom skills for Claude Cowork sessions.

## Usage

At the start of each Cowork session, ask Claude to:
> "Bootstrap my skills from GitHub"

Or manually tell Claude:
> "Clone https://github.com/ericjhensal/cowork-skills and copy the skills into .claude/skills/"

## Structure

- `skills/` — Custom SKILL.md files, one folder per skill
- `scripts/` — Setup and utility scripts for FOUCAULT

## Adding New Skills

1. Create skills in Cowork as usual
2. Ask Claude to save them to outputs
3. Run `sync-to-github.ps1` to push changes

"@
Set-Content -Path "README.md" -Value $readme

# Step 7: Create sync script
$syncScript = @'
# Quick sync: push local skill changes to GitHub
Set-Location "$env:USERPROFILE\Projects\cowork-skills"
git add -A
$msg = "Sync skills - $(Get-Date -Format 'yyyy-MM-dd HH:mm')"
git commit -m $msg
git push origin main
Write-Host "Skills synced to GitHub." -ForegroundColor Green
'@
Set-Content -Path "scripts\sync-to-github.ps1" -Value $syncScript

# Step 8: Commit everything
git add -A
git commit -m "Initial cowork skills setup"

# Step 9: Create GitHub repo and push
Write-Host ""
Write-Host "[+] Creating GitHub repo..." -ForegroundColor Yellow
gh repo create $repoName --private --source . --remote origin --push

Write-Host ""
Write-Host "=== SETUP COMPLETE ===" -ForegroundColor Green
Write-Host ""
Write-Host "Your skills repo is live at: https://github.com/ericjhensal/$repoName" -ForegroundColor Cyan
Write-Host "Local path: $repoPath" -ForegroundColor Cyan
Write-Host ""
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. In each new Cowork session, say: 'Bootstrap my skills from GitHub'" -ForegroundColor White
Write-Host "  2. After creating new skills, say: 'Save skills to outputs'" -ForegroundColor White
Write-Host "  3. Then run: .\scripts\sync-to-github.ps1" -ForegroundColor White
