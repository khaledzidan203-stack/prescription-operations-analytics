param(
    [string]$RepositoryRoot = (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$sampleRoot = Join-Path $RepositoryRoot "sample-data"
$errors = [System.Collections.Generic.List[string]]::new()

$schemas = [ordered]@{
    "sites.synthetic.csv" = @(
        "site_id", "site_code", "site_name", "region", "is_active")
    "operational-records.synthetic.csv" = @(
        "record_id", "synthetic_subject_id", "synthetic_subject_name",
        "site_id", "workflow_category", "received_at_utc", "status",
        "scheduled_at_utc", "fulfilment_status", "known_value")
    "items.synthetic.csv" = @(
        "item_id", "item_code", "item_name", "item_group",
        "current_reference_value")
    "exceptions.synthetic.csv" = @(
        "exception_id", "record_id", "site_id", "item_id",
        "required_quantity", "target_date", "status", "snapshot_id")
    "transfer-events.synthetic.csv" = @(
        "transfer_id", "record_id", "source_site_id",
        "destination_site_id", "status", "created_at_utc", "received_at_utc")
}

$tables = @{}
foreach ($schema in $schemas.GetEnumerator()) {
    $path = Join-Path $sampleRoot $schema.Key
    if (-not (Test-Path -LiteralPath $path -PathType Leaf)) {
        $errors.Add("Missing required synthetic file: $($schema.Key)")
        continue
    }

    $rows = @(Import-Csv -LiteralPath $path)
    if ($rows.Count -eq 0) {
        $errors.Add("Synthetic file has no rows: $($schema.Key)")
        continue
    }

    $columns = @($rows[0].PSObject.Properties.Name)
    foreach ($required in $schema.Value) {
        if ($required -notin $columns) {
            $errors.Add("$($schema.Key) is missing column $required")
        }
    }
    $tables[$schema.Key] = $rows

    $raw = Get-Content -LiteralPath $path -Raw
    if ($raw -match "(?<![A-Za-z0-9])\d{10}(?![A-Za-z0-9])") {
        $errors.Add("$($schema.Key) contains a ten-digit identity-like value")
    }
}

if ($tables.ContainsKey("sites.synthetic.csv")) {
    foreach ($row in $tables["sites.synthetic.csv"]) {
        if ($row.site_id -notmatch "^DEMO-SITE-\d{3}$" -or
            $row.site_code -notmatch "^SITE-\d{3}$") {
            $errors.Add("A Site row does not use the DEMO identifier pattern")
        }
    }
}

if ($tables.ContainsKey("operational-records.synthetic.csv")) {
    foreach ($row in $tables["operational-records.synthetic.csv"]) {
        if ($row.record_id -notmatch "^DEMO-REC-\d{6}$" -or
            $row.synthetic_subject_id -notmatch "^SYN-SUB-\d{6}$" -or
            $row.synthetic_subject_name -notmatch "^Synthetic Subject \d{3}$") {
            $errors.Add("An Operational Record row does not use explicit synthetic identifiers")
        }
        if ($row.workflow_category -notin @("Workflow Alpha", "Workflow Beta", "Workflow Gamma")) {
            $errors.Add("An Operational Record row has an unsupported workflow category")
        }
        if ($row.status -notin @("Open", "Completed", "Deferred")) {
            $errors.Add("An Operational Record row has an unsupported status")
        }
    }
}

if ($tables.ContainsKey("exceptions.synthetic.csv")) {
    foreach ($row in $tables["exceptions.synthetic.csv"]) {
        $quantity = 0
        if (-not [int]::TryParse($row.required_quantity, [ref]$quantity) -or $quantity -le 0) {
            $errors.Add("An Exception row has a non-positive quantity")
        }
    }
}

if ($errors.Count -gt 0) {
    Write-Host "SYNTHETIC DATA VALIDATION: FAIL"
    $errors | Sort-Object -Unique | ForEach-Object { Write-Host "- $_" }
    exit 1
}

Write-Host "SYNTHETIC DATA VALIDATION: PASS"
Write-Host "Files validated: $($schemas.Count)"
Write-Host "Real identity patterns found: 0"
