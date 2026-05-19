# Local and GitHub Sync Guide / 本地与 GitHub 同步新手指南

This guide explains how to update files locally and sync them to GitHub.

这份指南适合 GitHub 新手，用来理解本地文件和 GitHub 远端仓库之间如何更新。

## 1. Key Ideas / 核心概念

Local folder / 本地文件夹:

- The folder on your computer.
- Example: `C:\Users\haushuk\Documents\New project\ai-web3-school-cohort-0`

Git repository / Git 仓库:

- A folder tracked by Git.
- Git records changes over time.

Commit / 提交:

- A saved snapshot of your changes.
- Think of it as a checkpoint.

GitHub remote repository / GitHub 远端仓库:

- The online copy of your repository.
- Other people can view it if it is public.

Push / 推送:

- Upload local commits to GitHub.

Pull / 拉取:

- Download the latest changes from GitHub to your computer.

## 2. Daily Beginner Workflow / 每日新手流程

### Step A: Edit files / 编辑文件

Example:

1. Copy `templates/daily-note.md`.
2. Rename it as `daily/YYYY-MM-DD.md`.
3. Fill in what you learned, built, and want to ask.

### Step B: Check status / 查看状态

Run:

```powershell
git status
```

You will see which files changed.

### Step C: Review privacy / 检查隐私

Before committing, check:

- No private key.
- No seed phrase.
- No API key.
- No personal account screenshot.
- No ID document.
- No private course content copied directly.

### Step D: Stage files / 暂存文件

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

## 3. First-Time Setup / 第一次设置

### Install GitHub CLI / 安装 GitHub CLI

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

### Login / 登录

Run:

```powershell
gh auth login
```

Recommended choices:

- GitHub.com
- HTTPS
- Login with a web browser

### Create public repository / 创建公开仓库

From inside the local repository folder:

```powershell
gh repo create ai-web3-school-cohort-0 --public --source . --remote origin
```

Then push:

```powershell
git push -u origin main
```

Important: repo creation and push should be manually confirmed before running.

重要提醒：创建 GitHub 仓库和 push 前都应人工确认。

## 4. Common Commands / 常用命令

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

## 5. What to Do When Something Feels Wrong / 出错时怎么办

If you are unsure, stop before running commit or push.

如果不确定，先停在 commit 或 push 之前。

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

## 6. AI Agent Confirmation Rules / AI Agent 确认规则

The AI Learning Agent can help draft files, explain commands, and check repository status.

Before the following actions, the human learner must confirm:

- create GitHub repository;
- stage files with `git add`;
- create commit with `git commit`;
- push to GitHub with `git push`;
- submit links to WCB or any public platform.

AI 可以帮助写草稿、解释命令、检查状态。但以下动作必须由学习者人工确认：

- 创建 GitHub 仓库；
- 使用 `git add` 暂存文件；
- 使用 `git commit` 创建提交；
- 使用 `git push` 推送到 GitHub；
- 向 WCB 或公开平台提交链接。

