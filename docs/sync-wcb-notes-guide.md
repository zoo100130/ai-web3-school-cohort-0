# WCB Notes 同步指南

這份指南說明如何把 WCB 共學倉庫中的個人筆記：

https://github.com/IntensiveCoLearning/AI-Web3-School/blob/main/notes/zoo100130.md

同步更新到自己的學習倉庫：

https://github.com/zoo100130/ai-web3-school-cohort-0/tree/main/daily

## 同步邏輯

來源檔案 `zoo100130.md` 的 `## Notes` 區塊會依照日期拆分，例如：

```markdown
# 2026-05-19
...

# 2026-05-18
...
```

同步後，每個日期會寫入自己的每日筆記：

```text
daily/2026-05-19.md
daily/2026-05-18.md
```

同步內容會被包在標記之間：

```markdown
<!-- WCB_SYNC_START: 2026-05-19 -->
...
<!-- WCB_SYNC_END: 2026-05-19 -->
```

之後重跑同步時，只會更新這段 WCB 同步區塊，不會覆蓋同一份 daily 檔案裡其他自己寫的內容。

## 手動製作流程

### 1. 打開來源筆記

打開：

https://github.com/IntensiveCoLearning/AI-Web3-School/blob/main/notes/zoo100130.md

切換到 Raw 版本會更容易複製：

https://raw.githubusercontent.com/IntensiveCoLearning/AI-Web3-School/main/notes/zoo100130.md

### 2. 找到 `## Notes`

只同步 `## Notes` 底下的每日內容。

不要同步上方的個人介紹、Telegram、或其他你不想放進自己 repo 的資料。

### 3. 依日期切分內容

每個日期從這種標題開始：

```markdown
# 2026-05-19
```

把這個日期底下的內容複製出來，直到下一個日期標題前停止。

### 4. 建立或更新 daily 檔案

在自己的 repo 裡建立對應檔案：

```text
daily/YYYY-MM-DD.md
```

例如：

```text
daily/2026-05-19.md
```

### 5. 加入同步區塊

把來源內容貼到 daily 檔案最下方，格式如下：

```markdown
## WCB Source Note / WCB 來源筆記

<!-- WCB_SYNC_START: 2026-05-19 -->

Source / 來源: https://raw.githubusercontent.com/IntensiveCoLearning/AI-Web3-School/main/notes/zoo100130.md

貼上 WCB 當日筆記內容

<!-- WCB_SYNC_END: 2026-05-19 -->
```

### 6. 隱私檢查

提交前確認：

- 沒有 API Key、私鑰、助記詞、token 或 `.env`。
- 沒有未公開會議連結。
- 沒有個人帳號、錢包、身分證件或敏感截圖。
- 沒有把私人課程內容整段搬運。
- 來源內容是你確認可以公開同步的筆記。

### 7. Git 更新

檢查變更：

```powershell
git status
git diff
```

暫存：

```powershell
git add daily docs scripts README.md
```

提交：

```powershell
git commit -m "Sync WCB daily notes"
```

推送：

```powershell
git push
```

## 使用同步腳本

本倉庫也提供一個 PowerShell 腳本：

```text
scripts/sync-wcb-notes.ps1
```

在 repo 根目錄執行：

```powershell
.\scripts\sync-wcb-notes.ps1
```

腳本會：

- 下載 WCB `zoo100130.md` Raw 檔。
- 只讀取 `## Notes` 區塊。
- 依照 `# YYYY-MM-DD` 切出每日內容。
- 寫入或更新 `daily/YYYY-MM-DD.md`。
- 使用 `WCB_SYNC_START` / `WCB_SYNC_END` 標記，避免覆蓋你自己寫的其他 daily 內容。

執行後仍然要人工確認：

```powershell
git status
git diff
```

確認沒有敏感資訊後，再 commit 和 push。

目前偏好：這個學習倉庫的同步與文件維護，預設由 Agent 在完成 `git diff` 與隱私檢查後 commit 並 push 到 GitHub；如果想先停在本機，請明確說「先不要 push」。

## GitHub Actions 自動同步

本倉庫已加入 GitHub Actions workflow：

```text
.github/workflows/sync-wcb-notes.yml
```

它會：

- 每 30 分鐘自動檢查一次 WCB `notes/zoo100130.md`。
- 也可以在 GitHub 的 Actions 頁面手動執行。
- 執行 `scripts/sync-wcb-notes.ps1`。
- 如果 `daily/` 有變化，就由 `github-actions[bot]` 自動 commit 並 push。
- 如果沒有變化，就不產生 commit。

手動觸發方式：

1. 打開自己的 repo。
2. 進入 `Actions`。
3. 選擇 `Sync WCB Notes`。
4. 點 `Run workflow`。

注意：因為 GitHub 不會在外部 repo 更新時直接觸發自己的 repo，所以這裡使用「定時檢查」來達成接近自動同步的效果。

## 建議日常流程

1. 先在 WCB 共學倉庫更新 `notes/zoo100130.md`。
2. 等待 GitHub Actions 自動同步，通常最多約 30 分鐘。
3. 如需立刻同步，到自己的 repo 的 Actions 頁面手動執行 `Sync WCB Notes`。
4. 打開 GitHub daily 目錄確認內容已更新。

本機手動同步仍可使用：

```powershell
.\scripts\sync-wcb-notes.ps1
git status
git diff
git add README.md daily/
git commit -m "Sync WCB daily notes"
git push
```
