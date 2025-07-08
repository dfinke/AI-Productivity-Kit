<#
.SYNOPSIS
Summarizes recent directory activity using AI.

.DESCRIPTION
Fetches recent directory changes since a specified time frame and uses AI to generate a summary table of activity.

.PARAMETER timeFrame
The time frame to look back for directory changes (default: 'last week').

.PARAMETER Model
The AI model to use for summarization (default: 'github:openai/gpt-4.1').

.EXAMPLE
Get-RecentWork -timeFrame "last 3 days"

.EXAMPLE
Get-RecentWork -Model "github:openai/gpt-4.1"

.NOTES
Requires the PSAISuite module and access to OpenAI GPT models. The default model is 'github:openai/gpt-4.1'.
#>
function Get-RecentWork {
    [CmdletBinding()]
    param(
        $timeFrame = "last week",
        [string]$Model = "github:openai/gpt-4.1"
    )

    $prompt = @"
Date: $(Get-Date)
If there is no recent directory activity, say so.

Give me a summary of all directory changes (by LastWriteTime) since $timeFrame.

Sort by date, recent first.
Show a table with directory name and last write time.
First line is As of: <date range>
No explanation, just the summary table.
"@

    Write-Host "Fetching recent directory activity since $timeFrame..." -ForegroundColor Cyan
    $data = Get-ChildItem -Directory | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) } | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime

    if (-not $data) {
        Write-Host "No recent directory activity found for the specified time frame." -ForegroundColor Red
        return
    }

    Write-Host "AI is summarizing recent work..." -ForegroundColor Green

    if ($PSBoundParameters.ContainsKey('Model')) {
        $response = $data | Invoke-ChatCompletion $prompt -Model $Model
    }
    else {
        $response = $data | Invoke-ChatCompletion $prompt -Model "openai:gpt-4.1"
    }

    Write-Verbose "AI prompt sent: $prompt"
    Write-Verbose "AI response received: $response"
    if (Get-Command glow -ErrorAction SilentlyContinue) {
        $response | glow
        return
    }

    $response
}
