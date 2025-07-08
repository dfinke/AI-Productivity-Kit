<#
.SYNOPSIS
Summarizes recent Git changes using AI for standup reports.

.DESCRIPTION
Fetches recent Git log entries since a specified time frame and uses AI to generate a categorized summary for standup meetings.

.PARAMETER timeFrame
The time frame to look back for Git changes (e.g., 'yesterday', 'last 24 hours').

.EXAMPLE
Get-StandUp -timeFrame "last 2 days"

.NOTES
Requires the PSAISuite module and access to OpenAI GPT models.
#>
function Get-StandUp {
    [CmdletBinding()]
    param(
        $timeFrame = "yesterday",
        [string]$Model = "openai:gpt-4.1"
        #$timeFrame = "last 24 hours"
    )

    $prompt = @"
Date:$(get-date) 
If there is no git log data, say so.

Give me a summary of all changes to git since $timeFrame, category, and author. 

group by category - one category can have multiple authors
do not repeat categories
sort by category
one line for each author with a summary, within the category

Expected output format:
First line is As of: <date range>

Just the summary in a markdown table: Category, Author, Summary

"@

    Write-Host "Fetching git log since $timeFrame..." -ForegroundColor Cyan
    $cmd = "git log --since=`"$timeFrame`" --pretty=format:`"%h - %an, %ar : %s`" --stat "

    #Write-Host $cmd -ForegroundColor Yellow
    Write-Verbose "Executing command: $cmd"
    
    $log = Invoke-Expression $cmd

    if (-not $log) {
        Write-Host "No git log data found for the specified time frame." -ForegroundColor Red
        exit
    }

    Write-Host "AI is summarizing the git log..." -ForegroundColor Green

    if ($PSBoundParameters.ContainsKey('Model')) {
        $response = $log | Invoke-ChatCompletion $prompt -Model $Model
    }
    else {
        $response = $log | Invoke-ChatCompletion $prompt -Model "openai:gpt-4.1"
    }

    Write-Verbose "AI prompt sent: $prompt"
    Write-Verbose "AI response received: $response"
    if (Get-Command glow -ErrorAction SilentlyContinue) {
        $response | glow
        return
    }

    $response
}
