# ============================================
# AUTO-INJECT SKILLS INTO COWORK SESSIONS
# Runs as a Windows Scheduled Task.
# Watches for new Cowork sessions and copies
# your persistent skills into them automatically.
# ============================================

$skillsSource = "$env:USERPROFILE\Projects\cowork-skills\skills"
$sessionsRoot = "$env:APPDATA\Claude\local-agent-mode-sessions"
$logFile = "$env:USERPROFILE\Projects\cowork-skills\inject-log.txt"

function Write-Log {
    param([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -Append -FilePath $logFile
}

# Verify skills source exists
if (-not (Test-Path $skillsSource)) {
    Write-Log "ERROR: Skills source not found at $skillsSource"
    exit 1
}

# Find all .claude/skills directories in active sessions
$skillsDirs = Get-ChildItem -Path $sessionsRoot -Recurse -Directory -Filter "skills" -ErrorAction SilentlyContinue |
    Where-Object { $_.Parent.Name -eq ".claude" } |
    Sort-Object LastWriteTime -Descending

if ($skillsDirs.Count -eq 0) {
    Write-Log "No Cowork session skills directories found."
    exit 0
}

# Get all custom skill folder names from source
$sourceSkills = Get-ChildItem -Path $skillsSource -Directory -ErrorAction SilentlyContinue

foreach ($targetDir in $skillsDirs) {
    foreach ($skill in $sourceSkills) {
        $targetSkillPath = Join-Path $targetDir.FullName $skill.Name
        $sourceSkillMd = Join-Path $skill.FullName "SKILL.md"

        if (-not (Test-Path $sourceSkillMd)) { continue }

        # Check if skill already exists and is up to date
        $targetSkillMd = Join-Path $targetSkillPath "SKILL.md"
        if (Test-Path $targetSkillMd) {
            $sourceHash = (Get-FileHash $sourceSkillMd).Hash
            $targetHash = (Get-FileHash $targetSkillMd).Hash
            if ($sourceHash -eq $targetHash) { continue }
        }

        # Copy skill
        Copy-Item -Path $skill.FullName -Destination $targetSkillPath -Recurse -Force
        Write-Log "Injected skill '$($skill.Name)' into $($targetDir.FullName)"
    }
}
