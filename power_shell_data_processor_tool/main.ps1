# Power Shell Data Processor Tool
# Main Script

param(
    [Parameter(Mandatory=$true)]
    [string]$InputPath,

    [Parameter(Mandatory=$true)]
    [string]$OutputPath,

    [Parameter(Mandatory=$false)]
    [ValidateSet("CSV", "JSON", "XML")]
    [string]$Format = "CSV",

    [Parameter(Mandatory=$false)]
    [switch]$ValidateOnly
)

function Write-Log {
    param([string]$Message)
    Write-Host "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss") - $Message"
}

function Validate-Input {
    param([string]$Path)
    if (-not (Test-Path $Path)) {
        Write-Error "Input path does not exist: $Path"
        return $false
    }
    return $true
}

function Process-Data {
    param([string]$InputPath, [string]$OutputPath, [string]$Format)
    
    Write-Log "Reading data from $InputPath"
    $Data = Import-Csv -Path $InputPath
    
    if ($Format -eq "CSV") {
        $Data | Export-Csv -Path $OutputPath -NoTypeInformation
    } elseif ($Format -eq "JSON") {
        $Data | ConvertTo-Json | Out-File -FilePath $OutputPath
    } elseif ($Format -eq "XML") {
        $Data | ConvertTo-Xml -NoTypeInformation | Out-File -FilePath $OutputPath
    }
    
    Write-Log "Data processed and saved to $OutputPath"
}

function Validate-Data {
    param([string]$InputPath)
    
    Write-Log "Validating data from $InputPath"
    $Data = Import-Csv -Path $InputPath
    $Errors = @()
    
    foreach ($Row in $Data) {
        foreach ($Property in $Row.PSObject.Properties) {
            if ([string]::IsNullOrWhiteSpace($Property.Value)) {
                $Errors += "Row $($_.RowIndex) has empty value for $($Property.Name)"
            }
        }
    }
    
    if ($Errors.Count -eq 0) {
        Write-Log "Validation successful"
    } else {
        Write-Error "Validation failed: $([string]::Join(', ', $Errors))"
    }
}

# Main execution
if (-not (Validate-Input $InputPath)) {
    exit 1
}

if ($ValidateOnly) {
    Validate-Data -InputPath $InputPath
} else {
    Process-Data -InputPath $InputPath -OutputPath $OutputPath -Format $Format
}
