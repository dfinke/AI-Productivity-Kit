<#
.SYNOPSIS
Summarizes recent directory activity using AI.

.DESCRIPTION
Fetches recent directory changes since a specified time frame and uses AI to generate a summary table of activity.

.PARAMETER Path
The path to the directory to scan for recent activity. Defaults to the current directory.

.PARAMETER Model
The AI model to use for summarization (default: 'github:openai/gpt-4.1').

.EXAMPLE
Get-RecentWork -Path "C:\Projects" -Model "github:openai/gpt-4.1"

.EXAMPLE
Get-RecentWork

.NOTES
Requires the PSAISuite module and access to OpenAI GPT models. The default model is 'github:openai/gpt-4.1'.
#>
function Get-RecentWork {
    [CmdletBinding()]
    param(
        [string]$Path = ".",
        [string]$Model = "github:openai/gpt-4.1"
    )

    $prompt = @"
Date: $(Get-Date)
If there is no recent directory activity, say so.

Give me a summary of all directory changes (by LastWriteTime) from the last week.

Sort by date, recent first.
Show a table with directory name and last write time.
First line is As of: <date range>
No explanation, just the summary table.
"@

    Write-Host "Fetching recent directory activity from the last week in path: $Path..." -ForegroundColor Cyan
    $data = Get-ChildItem -Path $Path -Directory | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) } | Sort-Object LastWriteTime -Descending | Select-Object Name, LastWriteTime

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
