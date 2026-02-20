# FOUCAULT — Environment Reference

Machine name: FOUCAULT
User: Eric (ericjhensal@gmail.com)
OS: Windows 11 Home (64-bit, Build 26200)

## Key Paths
- Python: C:\Users\ericj\AppData\Local\Programs\Python\Python312\python.exe
- Node: C:\Program Files\nodejs\node.exe
- Git: C:\Program Files\Git\cmd
- GitHub CLI: C:\Program Files\GitHub CLI\
- VS Code: installed with Python/Jupyter extensions
- FFmpeg: C:\Program Files\FFmpeg\bin\ffmpeg.exe
- Pandoc: C:\Users\ericj\AppData\Local\Pandoc\pandoc.exe
- LaTeX (MiKTeX): C:\Users\ericj\AppData\Local\Programs\MiKTeX\miktex\bin\x64\
- Tesseract OCR: C:\Program Files\Tesseract-OCR
- LibreOffice: C:\Program Files\LibreOffice\program\soffice.exe
- wkhtmltopdf: C:\Program Files\wkhtmltopdf\bin

## Git / GitHub
- GitHub user: ericjhensal
- Auth: gh CLI logged in via keyring (HTTPS)
- Git rewrite: HTTPS forced over SSH (git config --global url."https://github.com/".insteadOf "git@github.com:")
- SSH key exists (ed25519) but passphrase is unknown — always use HTTPS
- Token scopes: admin:public_key, gist, read:org, repo, workflow

## Python Packages (notable)
pandas, numpy, matplotlib, scipy, statsmodels, scikit-learn, nltk, spacy, textblob,
networkx, wordcloud, beautifulsoup4, lxml, requests, httpx, selenium, playwright,
anthropic, Flask, streamlit, atproto (Bluesky), Mastodon.py, yfinance, fredapi,
pdfkit, pdfplumber, pdfminer.six, PyMuPDF, PyPDF2, pillow, opencv-python,
pytesseract, Jinja2, python-dotenv, pydantic, tqdm

## CLI Tools
- sqlite3: installed via choco
- jq: installed via choco
- curl: system
- tar: system
- ssh/scp: system OpenSSH
- wsl: available

## Cowork Skills Pipeline
- Skills repo: https://github.com/ericjhensal/cowork-skills (public)
- Local repo: C:\Users\ericj\Projects\cowork-skills
- Auto-inject: Windows Scheduled Task "CoworkSkillsAutoInject" runs every 2 minutes
  - Uses wscript.exe + silent-inject.vbs wrapper (no window flash)
  - Scans all Cowork session dirs under AppData\Roaming\Claude\local-agent-mode-sessions
  - Copies skills from Projects\cowork-skills\skills\ into each session's .claude\skills\
- To add a new skill: drop folder with SKILL.md into Projects\cowork-skills\skills\
- To sync to GitHub: run Projects\cowork-skills\scripts\sync-to-github.ps1

## Eric's Work & Preferences
- Fields: politics, society, culture
- Intellectual framework: non-obvious sociology (Randall Collins), sociological imagination
  (C. Wright Mills), Foucault, George Herbert Mead, William James, Merleau-Ponty
- Writing style: Strunk & White — say more with less
- Problem-solving: persistent, tenacious, pragmatic. Try every available strategy before
  calling something "good enough." Challenge assumptions. No conspiracy thinking.

## Known Issues / Gotchas
- If git starts asking for SSH passphrase: run git config --global --unset url."git@github.com:".insteadOf
- Node was installed via choco but needed manual PATH addition
- Playwright Python installed but browser binaries may need: python -m playwright install
