# Local and GitHub Sync Guide / 本地與 GitHub 同步新手指南

This guide explains how to update files locally and sync them to GitHub.

這份指南適合 GitHub 新手，用來理解本地檔案和 GitHub 遠端倉庫之間如何更新。

## 1. Key Ideas / 核心概念

Local folder / 本地資料夾:

- The folder on your computer.
- Example: `C:\Users\haushuk\Documents\New project\ai-web3-school-cohort-0`

Git repository / Git 倉庫:

- A folder tracked by Git.
- Git records changes over time.

Commit / 提交:

- A saved snapshot of your changes.
- Think of it as a checkpoint.

GitHub remote repository / GitHub 遠端倉庫:

- The online copy of your repository.
- Other people can view it if it is public.

Push / 推送:

- Upload local commits to GitHub.

Pull / 拉取:

- Download the latest changes from GitHub to your computer.

## 2. Daily Beginner Workflow / 每日新手流程

### Step A: Edit files / 編輯檔案

Example:

1. Copy `templates/daily-note.md`.
2. Rename it as `daily/YYYY-MM-DD.md`.
3. Fill in what you learned, built, and want to ask.

### Step B: Check status / 查看狀態

Run:

```powershell
git status
```

You will see which files changed.

### Step C: Review privacy / 檢查隱私

Before committing, check:

- No private key.
- No seed phrase.
- No API key.
- No personal account screenshot.
- No ID document.
- No private course content copied directly.

### Step D: Stage files / 暫存檔案

Run:

```powershell
git add README.md profile.md learning-plan.md daily tasks experiments handbook-feedback hackathon submissions templates docs
```

For normal daily updates, you can also run:

```powershell
git add .
```

Only use `git add .` after checking that the folder contains no private files.

### Step E: Commit / 本地提交

Run:

```powershell
git commit -m "Add daily learning note"
```

Use short commit messages:

- `Add first learning plan`
- `Add daily note for 2026-05-19`
- `Add hackathon idea bank`
- `Update handbook feedback draft`

### Step F: Push to GitHub / 推送到 GitHub

Run:

```powershell
git push
```

If it is your first push, Git may ask you to set the upstream branch. The command usually looks like:

```powershell
git push -u origin main
```

## 3. First-Time Setup / 第一次設定

### Install GitHub CLI / 安裝 GitHub CLI

GitHub CLI is called `gh`.

Windows installation options:

- Download from https://cli.github.com/
- Or install with winget:

```powershell
winget install --id GitHub.cli
```

After installation, restart PowerShell and check:

```powershell
gh --version
```

### Login / 登入

Run:

```powershell
gh auth login
```

Recommended choices:

- GitHub.com
- HTTPS
- Login with a web browser

### Create public repository / 建立公開倉庫

From inside the local repository folder:

```powershell
gh repo create ai-web3-school-cohort-0 --public --source . --remote origin
```

Then push:

```powershell
git push -u origin main
```

Important: repo creation and push should be manually confirmed before running.

重要提醒：建立 GitHub 倉庫和 push 前都應人工確認。

## 4. Common Commands / 常用指令

Check current folder:

```powershell
Get-Location
```

See files:

```powershell
Get-ChildItem
```

Check Git status:

```powershell
git status
```

See commit history:

```powershell
git log --oneline
```

Add all safe changes:

```powershell
git add .
```

Commit:

```powershell
git commit -m "Your message"
```

Push:

```powershell
git push
```

Pull:

```powershell
git pull
```

## 5. What to Do When Something Feels Wrong / 出錯時怎麼辦

If you are unsure, stop before running commit or push.

如果不確定，先停在 commit 或 push 之前。

Safe commands to inspect:

```powershell
git status
git diff
git log --oneline
```

Do not run destructive commands unless you know exactly what they do:

```powershell
git reset --hard
git clean -fd
```

## 6. AI Agent Confirmation Rules / AI Agent 確認規則

The AI Learning Agent can help draft files, explain commands, and check repository status.

Before the following actions, the human learner must confirm:

- create GitHub repository;
- stage files with `git add`;
- create commit with `git commit`;
- push to GitHub with `git push`;
- submit links to WCB or any public platform.

AI 可以幫助寫草稿、解釋指令、檢查狀態。但以下動作必須由學習者人工確認：

- 建立 GitHub 倉庫；
- 使用 `git add` 暫存檔案；
- 使用 `git commit` 建立提交；
- 使用 `git push` 推送到 GitHub；
- 向 WCB 或公開平台提交連結。
