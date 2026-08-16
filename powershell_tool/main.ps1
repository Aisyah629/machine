#Requires -Version 5.1

<#
.SYNOPSIS
    Automated System Workflow Orchestrator.
.DESCRIPTION
    Manages complex multi-step task execution with robust error handling and logging capabilities.
.EXAMPLE
    .\main.ps1 -WorkflowFile ".\workflow.json"
.PARAMETER WorkflowFile
    Path to the JSON file defining the workflow.
.PARAMETER LogFile
    Path to the log file. Defaults to ".\workflow.log".
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$WorkflowFile,
    
    [string]$LogFile = ".\workflow.log"
)

# Function to write logs
function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "[$timestamp] [$Level] $Message"
    Add-Content -Path $LogFile -Value $logEntry -ErrorAction SilentlyContinue
    Write-Host $logEntry
}

# Function to execute a step with error handling and retry
function Invoke-WorkflowStep {
    param(
        [string]$Name,
        [string]$Command,
        [int]$Timeout = 30,
        [int]$Retry = 3,
        [int]$RetryDelay = 5
    )
    
    Write-Log "Starting step: $Name"
    $attempts = 0
    $success = $false
    
    while ($attempts -lt $Retry -and -not $success) {
        try {
            $attempts++
            Write-Log "Attempt $attempts of $Retry for step: $Name"
            
            # Execute the command
            $result = Invoke-Expression $Command 2>&1
            
            # Check for errors
            if ($result -is [System.Management.Automation.ErrorRecord]) {
                throw $result
            }
            
            Write-Log "Step $Name executed successfully. Output: $result"
            $success = $true
        }
        catch {
            Write-Log "Error executing step $Name: $_" -Level "ERROR"
            if ($attempts -lt $Retry) {
                Write-Log "Waiting $RetryDelay seconds before retry..."
                Start-Sleep -Seconds $RetryDelay
            }
        }
    }
    
    if ($success) {
        Write-Log "Step $Name completed successfully."
    }
    else {
        Write-Log "Step $Name failed after $Retry attempts." -Level "ERROR"
        throw "Step $Name failed."
    }
}

# Main execution
try {
    Write-Log "Starting workflow orchestration."
    
    # Load workflow from JSON
    if (-not (Test-Path $WorkflowFile)) {
        throw "Workflow file not found: $WorkflowFile"
    }
    
    $workflow = Get-Content -Path $WorkflowFile | ConvertFrom-Json
    Write-Log "Loaded workflow: $($workflow.workflow)"
    
    # Execute each step
    foreach ($step in $workflow.steps) {
        Invoke-WorkflowStep -Name $step.name -Command $step.command -Timeout $step.timeout -Retry $step.retry -RetryDelay $step.retryDelay
    }
    
    Write-Log "Workflow orchestration completed successfully."
}
catch {
    Write-Log "Workflow orchestration failed: $_" -Level "ERROR"
    exit 1
}
