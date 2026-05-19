param(
    [string]$SourceUrl = "https://raw.githubusercontent.com/IntensiveCoLearning/AI-Web3-School/main/notes/zoo100130.md",
    [string]$DailyDir = "daily"
)

$ErrorActionPreference = "Stop"
$repoRoot = Resolve-Path -LiteralPath (Join-Path $PSScriptRoot "..")
$dailyPath = Join-Path $repoRoot $DailyDir
$encoding = New-Object System.Text.UTF8Encoding($false)

New-Item -ItemType Directory -Force -Path $dailyPath | Out-Null

Write-Host "Fetching WCB note from:"
Write-Host $SourceUrl

$source = (Invoke-WebRequest -Uri $SourceUrl -UseBasicParsing).Content
$source = $source -replace "`r`n", "`n"
$source = $source -replace "`r", "`n"

$notesIndex = $source.IndexOf("## Notes")
if ($notesIndex -lt 0) {
    throw "Cannot find '## Notes' section in source note."
}

$notes = $source.Substring($notesIndex)
$datePattern = '(?m)^# (?<date>\d{4}-\d{2}-\d{2})\s*$'
$matches = [regex]::Matches($notes, $datePattern)

if ($matches.Count -eq 0) {
    throw "Cannot find dated note sections like '# 2026-05-19'."
}

$updated = @()

for ($i = 0; $i -lt $matches.Count; $i++) {
    $date = $matches[$i].Groups["date"].Value
    $contentStart = $matches[$i].Index + $matches[$i].Length
    if ($i -lt ($matches.Count - 1)) {
        $contentEnd = $matches[$i + 1].Index
    } else {
        $contentEnd = $notes.Length
    }

    $dailyContent = $notes.Substring($contentStart, $contentEnd - $contentStart).Trim()
    $dailyContent = $dailyContent -replace '(?m)^<!-- DAILY_CHECKIN_\d{4}-\d{2}-\d{2}_START -->\s*', ''
    $dailyContent = $dailyContent -replace '(?m)^<!-- DAILY_CHECKIN_\d{4}-\d{2}-\d{2}_END -->\s*', ''
    $dailyContent = $dailyContent -replace '(?m)^<!-- Content_START -->\s*', ''
    $dailyContent = $dailyContent -replace '(?m)^<!-- Content_END -->\s*', ''
    $dailyContent = $dailyContent.Trim()

    if ([string]::IsNullOrWhiteSpace($dailyContent)) {
        continue
    }

    $targetFile = Join-Path $dailyPath "$date.md"
    $beginMarker = "<!-- WCB_SYNC_START: $date -->"
    $endMarker = "<!-- WCB_SYNC_END: $date -->"
    $syncBlock = @"

## WCB Source Note

$beginMarker

Source: $SourceUrl

$dailyContent

$endMarker
"@.Trim()

    if (Test-Path -LiteralPath $targetFile) {
        $targetText = [System.IO.File]::ReadAllText($targetFile, $encoding)
    } else {
        $targetText = @"
# Daily Check-in

Date: $date

"@.Trim()
    }

    $escapedBegin = [regex]::Escape($beginMarker)
    $escapedEnd = [regex]::Escape($endMarker)
    $blockPattern = "(?s)\n*## WCB Source Note.*?$escapedBegin.*?$escapedEnd"

    if ([regex]::IsMatch($targetText, $blockPattern)) {
        $targetText = [regex]::Replace($targetText, $blockPattern, "`n`n$syncBlock")
    } else {
        $targetText = $targetText.TrimEnd() + "`n`n" + $syncBlock
    }

    [System.IO.File]::WriteAllText($targetFile, $targetText.TrimEnd() + "`n", $encoding)
    $updated += $targetFile
}

Write-Host "Updated daily files:"
$updated | ForEach-Object { Write-Host "- $_" }
