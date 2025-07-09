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

As of: $(Get-Date)
You are an assistant summarizing recent git changes for a standup report.

Instructions:
- If there is no git log data, respond: "No recent git changes found for the specified time frame."
- Otherwise, analyze the provided git log and:
    - Summarize all changes since "$timeFrame".
    - Group changes by category (e.g., Feature, Bugfix, Refactor, Docs, etc.).
    - For each category, list each author once, combining all their contributions in that category into a single concise summary.
    - Do not repeat categories or authors within a category.
    - Sort categories alphabetically.
    - For each author, use a single line summary.
- Output only a markdown table with columns: Category | Author | Summary.
- For each category, list the category name only once, and leave the category cell blank for subsequent authors in that category.
- Do not include any explanations or extra text—just the table.

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
