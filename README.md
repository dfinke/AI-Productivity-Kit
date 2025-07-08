# AI-Productivity-Kit

## Project Overview

**AI-Productivity-Kit** is a PowerShell module that provides a set of AI-powered utilities to boost your daily productivity and streamline workflows. It leverages generative AI (via OpenAI GPT models through the PSAISuite module) to automate and assist with common tasks that professionals face each day. By integrating AI into the PowerShell environment, this kit can **summarize recent work, generate status reports, and analyze activity logs** – all within your familiar command-line workflow. In short, AI-Productivity-Kit is designed to *supercharge your daily tasks and workflows* by offloading tedious summarization and reporting tasks to an intelligent assistant running right from PowerShell.

## Features

- **`Get-RecentWork`** – *Summarize recent file system activity using AI.* Scans the current directory for recent changes (within a specified timeframe) and uses an AI model to produce a concise summary table of the activity.
- **`Get-StandUp`** – *Generate AI-assisted stand-up reports from Git history.* Fetches recent Git commit logs and summarizes them into a markdown report categorized by type of contribution.

## Installation

**Prerequisites:** PowerShell 5.1+ and the PSAISuite module. Also ensure you have an OpenAI API key or compatible provider key in your environment.

```powershell
Install-Module AIProductivityKit -Scope CurrentUser
Import-Module AIProductivityKit
```

Or clone from GitHub and import the `.psd1` file manually.

## Usage

```powershell
Get-RecentWork -timeFrame "last 3 days"
Get-StandUp -timeFrame "yesterday"
```

These commands summarize directory and Git commit activity using AI, outputting structured markdown suitable for quick reviews or stand-up reports.

## Contributing

- Open issues for bugs or feature ideas.
- Submit PRs following project conventions.
- Use inline help metadata and add comments for clarity.

## License

MIT License. See the [LICENSE](./LICENSE) file for details.

---

*AI-Productivity-Kit brings the power of AI into your PowerShell toolbox, helping you automate the routine and focus on what matters.* 🚀
