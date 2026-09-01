param(
    [string]$RepositoryRoot =
        (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$root = (Resolve-Path -LiteralPath $RepositoryRoot).Path
$findings = [System.Collections.Generic.List[object]]::new()

$forbiddenExtensions = @(
    ".db", ".sqlite", ".mdf", ".ldf", ".bak", ".backup",
    ".pfx", ".p12", ".key", ".pem", ".zip", ".7z", ".xlsx", ".xls"
)
$forbiddenDirectories = @(
    "App_Data", "ChatAttachments", "bin", "obj", "Release",
    "Source_Archive", "logs", "private", "secrets"
)
$textExtensions = @(
    ".md", ".txt", ".csv", ".json", ".yml", ".yaml", ".py",
    ".sql", ".cs", ".ps1", ".example", ".gitignore"
)

function Add-Finding([string]$Rule, [string]$RelativePath) {
    $findings.Add([PSCustomObject]@{
        Rule = $Rule
        Path = $RelativePath.Replace("\", "/")
    })
}

$files = Get-ChildItem -LiteralPath $root -Recurse -File -Force |
    Where-Object { $_.FullName -notmatch "[\\/]\.git[\\/]" }

foreach ($file in $files) {
    $relative = [System.IO.Path]::GetRelativePath($root, $file.FullName)
    $segments = $relative -split "[\\/]"

    if ($forbiddenExtensions -contains $file.Extension.ToLowerInvariant()) {
        Add-Finding "prohibited-extension" $relative
    }

    if ($segments | Where-Object { $forbiddenDirectories -contains $_ }) {
        Add-Finding "prohibited-directory" $relative
    }

    if ($file.Length -gt 1MB) {
        Add-Finding "oversized-artifact" $relative
    }

    $isText =
        $textExtensions -contains $file.Extension.ToLowerInvariant() -or
        $file.Name -eq ".gitignore"

    if (-not $isText -or $relative -eq "scripts\scan-sensitive-paths.ps1") {
        continue
    }

    $content = Get-Content -LiteralPath $file.FullName -Raw
    $rules = [ordered]@{
        "absolute-windows-path" = "(?i)(?<![A-Za-z0-9])[A-Z]:\\[A-Za-z0-9_. -]+\\"
        "active-source-path" = "(?i)WasfatyCentral\\Source\\WasfatyCentral"
        "internal-hostname" = "(?i)\bDESKTOP-[A-Z0-9-]+\b|\bYOUR_SQL_SERVER\b"
        "connection-string" = "(?i)\b(Server|Data Source)\s*=\s*[^;\r\n]{3,};"
        "secret-assignment" = '(?i)\b(password|passwd|pwd|api[_-]?key|token|secret)\s*[:=]\s*[''"]?[^<\s''"]{4,}'
        "numeric-national-id" = "(?<![A-Za-z0-9])\d{10}(?![A-Za-z0-9])"
        "phone-like-number" = "(?<!\d)05\d{8}(?!\d)"
        "email-address" = "(?i)\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}\b"
    }

    foreach ($rule in $rules.GetEnumerator()) {
        if ($content -match $rule.Value) {
            Add-Finding $rule.Key $relative
        }
    }
}

if ($findings.Count -gt 0) {
    Write-Host "PUBLICATION SCAN: FAIL"
    $findings |
        Sort-Object Rule, Path -Unique |
        Format-Table -AutoSize
    exit 1
}

Write-Host "PUBLICATION SCAN: PASS"
Write-Host "Files scanned: $($files.Count)"
Write-Host "Sensitive findings: 0"
