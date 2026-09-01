param(
    [string]$RepositoryRoot =
        (Split-Path -Parent $PSScriptRoot)
)

$ErrorActionPreference = "Stop"
$sampleRoot = Join-Path $RepositoryRoot "sample-data"
$errors = [System.Collections.Generic.List[string]]::new()

$schemas = [ordered]@{
    "pharmacies.synthetic.csv" = @(
        "pharmacy_id", "pharmacy_code", "pharmacy_name", "city", "is_active")
    "prescriptions.synthetic.csv" = @(
        "prescription_id", "synthetic_national_id", "patient_name",
        "pharmacy_id", "record_type", "received_at_utc", "final_status",
        "next_fill_at_utc", "delivery_status", "known_value_sar")
    "items.synthetic.csv" = @(
        "item_id", "item_code", "item_name", "generic_name",
        "current_unit_price_sar")
    "missing-items.synthetic.csv" = @(
        "missing_item_id", "prescription_id", "pharmacy_id", "item_id",
        "required_quantity", "needed_by_date", "status", "procurement_batch")
    "transfers.synthetic.csv" = @(
        "transfer_id", "original_prescription_id", "source_prescription_id",
        "destination_prescription_id", "from_pharmacy_id", "to_pharmacy_id",
        "transfer_type", "status", "created_at_utc")
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

if ($tables.ContainsKey("pharmacies.synthetic.csv")) {
    foreach ($row in $tables["pharmacies.synthetic.csv"]) {
        if ($row.pharmacy_id -notmatch "^DEMO-PH-ID-\d{3}$" -or
            $row.pharmacy_code -notmatch "^DEMO-PH-\d{3}$") {
            $errors.Add("A Pharmacy row does not use the DEMO identifier pattern")
        }
    }
}

if ($tables.ContainsKey("prescriptions.synthetic.csv")) {
    foreach ($row in $tables["prescriptions.synthetic.csv"]) {
        if ($row.prescription_id -notmatch "^DEMO-RX-\d{6}$" -or
            $row.synthetic_national_id -notmatch "^SYN-NID-\d{6}$" -or
            $row.patient_name -notmatch "^Synthetic Patient \d{3}$") {
            $errors.Add("A Prescription row does not use explicit synthetic identifiers")
        }
        if ($row.record_type -notin @("WL e-RXs", "Run-X e-RXs", "Pick-up e-RXs")) {
            $errors.Add("A Prescription row has an unsupported synthetic record type")
        }
        if ($row.final_status -notin @("Done", "Not Yet")) {
            $errors.Add("A Prescription row has an unsupported final status")
        }
    }
}

if ($tables.ContainsKey("missing-items.synthetic.csv")) {
    foreach ($row in $tables["missing-items.synthetic.csv"]) {
        $quantity = 0
        if (-not [int]::TryParse($row.required_quantity, [ref]$quantity) -or
            $quantity -le 0) {
            $errors.Add("A Missing Item row has a non-positive quantity")
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
