# AI-Productivity-Kit

## Project Overview

**AI-Productivity-Kit** is a PowerShell module that provides a set of AI-powered utilities to boost your daily productivity and streamline workflows. It leverages generative AI (via OpenAI GPT models through the PSAISuite module) to automate and assist with common tasks that professionals face each day. By integrating AI into the PowerShell environment, this kit can **summarize recent work, generate status reports, and analyze activity logs** – all within your familiar command-line workflow. In short, AI-Productivity-Kit is designed to *supercharge your daily tasks and workflows* by offloading tedious summarization and reporting tasks to an intelligent assistant running right from PowerShell.

## Features

- **`Get-RecentWork`** – *Summarize recent file system activity using AI.*
  - Scans a specified directory (defaults to the current directory) for recent changes within a configurable time window (default: last 7 days).
  - Accepts `-Path` and `-DaysAgo` parameters for flexibility.
  - Checks if the directory exists and provides a clear error if not.
  - Uses an AI model to produce a concise summary table of the activity.

- **`Get-StandUp`** – *Generate AI-assisted stand-up reports from Git history.*
  - Fetches recent Git commit logs since a specified time frame (e.g., "yesterday", "last 2 days").
  - Checks if git is installed and informs the user if not.
  - Summarizes commit history into a markdown report categorized by type of contribution, with robust prompt logic for clear, non-redundant summaries.

## Installation

**Prerequisites:** PowerShell 5.1+ and the PSAISuite module. Also ensure you have an OpenAI API key or compatible provider key in your environment.

```powershell
Install-Module AIProductivityKit -Scope CurrentUser
Import-Module AIProductivityKit
```

Or clone from GitHub and import the `.psd1` file manually.

## Usage


```powershell
# Summarize recent activity in the current directory (last 7 days)
Get-RecentWork

# Summarize recent activity in a specific directory and time window
Get-RecentWork -Path "C:\Projects" -DaysAgo 3

# Generate a stand-up report from recent git history
Get-StandUp -timeFrame "yesterday"
```

**Note:**
- `Get-RecentWork` will inform you if the specified directory does not exist.
- `Get-StandUp` will check for git and prompt you to install it if missing.


These commands summarize directory and Git commit activity using AI, outputting structured markdown suitable for quick reviews or stand-up reports. Both commands now include improved error handling and more flexible parameters.

## Contributing

- Open issues for bugs or feature ideas.
- Submit PRs following project conventions.
- Use inline help metadata and add comments for clarity.

## License

MIT License. See the [LICENSE](./LICENSE) file for details.

---

*AI-Productivity-Kit brings the power of AI into your PowerShell toolbox, helping you automate the routine and focus on what matters.* 🚀
