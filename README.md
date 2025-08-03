# AI-Productivity-Kit

## Project Overview

**AI-Productivity-Kit** is a PowerShell module that provides a set of AI-powered utilities to boost your daily productivity and streamline workflows. It leverages generative AI (via OpenAI GPT models through the PSAISuite module) to automate and assist with common tasks that professionals face each day. 

## Features

- **`Get-StandUp`** – *Generate AI-assisted stand-up reports from Git history.*
  - Fetches recent Git commit logs since a specified time frame (e.g., "yesterday", "last 2 days").
  - Checks if git is installed and informs the user if not.
  - Summarizes commit history into a markdown report categorized by type of contribution, with robust prompt logic for clear, non-redundant summaries.
- **`Get-RecentWork`** – *Summarize recent file system activity using AI.*
  - Scans a specified directory (defaults to the current directory) for recent changes within a configurable time window (default: last 7 days).
  - Accepts `-Path` and `-DaysAgo` parameters for flexibility.
  - Checks if the directory exists and provides a clear error if not.
  - Uses an AI model to produce a concise summary table of the activity.

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

## GitHub Provider Integration

Unlock even more AI-powered productivity by connecting the PSAISuite module to your GitHub account. This enables access to advanced models and features using your own credentials.

### Getting Started

To use the GitHub provider, you’ll need a personal access token with the right permissions. Creating one is easy—just follow the official [GitHub Personal Access Token guide](https://docs.github.com/en/enterprise-server@3.16/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-personal-access-token-classic).

Once you have your token, set it as an environment variable in your PowerShell session:

```powershell
$env:GITHUB_TOKEN = "your-github-token"
```

This ensures seamless authentication and unlocks the full potential of PSAISuite’s GitHub integration.
$env:GITHUB_TOKEN = "your-github-token"
```

This ensures seamless authentication and unlocks the full potential of PSAISuite’s GitHub integration.
