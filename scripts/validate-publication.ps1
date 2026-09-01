param(
    [string]$RepositoryRoot =
        (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$requiredFiles = @(
    "README.md",
    "PUBLICATION_ALLOWLIST.md",
    "PUBLICATION_DENYLIST.md",
    "SANITIZATION_MANIFEST.md",
    "docs/README.md",
    "docs/architecture/system-context.md",
    "docs/workflows/wl-prescription-lifecycle.md",
    "docs/security/pharmacy-isolation.md",
    "docs/data_model/domain-model.md",
    "docs/kpi_dictionary/operational-kpis.md",
    "docs/validation/data-quality-rules.md",
    "docs/lessons_learned/project-lessons.md"
)

$missing = @($requiredFiles | Where-Object {
    -not (Test-Path -LiteralPath (Join-Path $RepositoryRoot $_) -PathType Leaf)
})

if ($missing.Count -gt 0) {
    Write-Host "PUBLICATION VALIDATION: FAIL"
    $missing | ForEach-Object { Write-Host "- Missing required file: $_" }
    exit 1
}

& (Join-Path $PSScriptRoot "scan-sensitive-paths.ps1") `
    -RepositoryRoot $RepositoryRoot
if (-not $?) { exit 1 }

& (Join-Path $PSScriptRoot "validate-synthetic-data.ps1") `
    -RepositoryRoot $RepositoryRoot
if (-not $?) { exit 1 }

Write-Host "PUBLICATION VALIDATION: PASS"
Write-Host "Required documentation present: $($requiredFiles.Count)"
