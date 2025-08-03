#Requires -Module PSAISuite

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
        [string]$Model = "openai:gpt-4.1",
        [switch]$Raw
    )

    $prompt = @"

As of: $(Get-Date)
You are an assistant summarizing recent git changes for a standup report.


Instructions:
- If there is no git log data, respond: "No recent git changes found for the specified time frame."
- Otherwise, analyze the provided git log and:
    - Summarize all changes since "$timeFrame".
    - Group changes by category (e.g., Feature, Bugfix, Refactor, Docs, etc.).
    - For each category, each author MUST appear only once. If an author has multiple contributions in a category, MERGE all their contributions into a single, concise summary line for that category. DO NOT repeat an author's name within a category under any circumstances.
    - Do not repeat categories.
    - Sort categories alphabetically.
    - For each author, use a single line summary.
- Output only a markdown table with columns: Category | Author | Summary.
- For each category, list the category name only once, and leave the category cell blank for subsequent authors in that category.
- Do not include any explanations or extra text—just the table.
- WARNING: If an author appears more than once in a category, your output is incorrect. Each author must have only one summary line per category.
- Example (note how each author appears only once per category, with all their contributions merged into one summary line):

| Category | Author            | Summary                                                      |
|----------|-------------------|--------------------------------------------------------------|
| Bugfix   | Megan Rogge       | Fixed issue #254720 and improved terminal/task state model.   |
|          | Ulugbek Abdullaev | Fixed baseline lookup and improved test script reliability.   |
| Docs     | Megan Rogge       | Added tests for TerminalAndTaskState and PromptElement.       |
| Feature  | Dirk Bäumer       | Rewrote TS context item computation and added inspector.      |
|          | Rob Lourens       | Added summarization experiments.                              |
| Refactor | Ulugbek Abdullaev | Removed unused code, sorted tests, updated cache file, etc.   |

"@

    if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
        Write-Host "Git is not installed or not available in the system PATH. Please install Git to use this function." -ForegroundColor Red
        return
    }

    Write-Host "Fetching git log since $timeFrame..." -ForegroundColor Cyan
    $cmd = "git log --since=`"$timeFrame`" --pretty=format:`"%h - %an, %ar : %s`" --stat "

    #Write-Host $cmd -ForegroundColor Yellow
    Write-Verbose "Executing command: $cmd"
    
    $log = Invoke-Expression $cmd

    if (-not $log) {
        Write-Host "No git log data found for the specified time frame." -ForegroundColor Red
        return
    }
    else {

        Write-Host "AI is summarizing the git log..." -ForegroundColor Green

        if ($PSBoundParameters.ContainsKey('Model')) {
            $response = $log | Invoke-ChatCompletion $prompt -Model $Model
        }
        else {
            $response = $log | Invoke-ChatCompletion $prompt -Model "openai:gpt-4.1"
        }

        Write-Verbose "AI prompt sent: $prompt"
        Write-Verbose "AI response received: $response"
        
        if ($Raw) {
            return $response
        }   

        if (Get-Command glow -ErrorAction SilentlyContinue) {
            $response | glow
            return
        }

        $response
    }
}
