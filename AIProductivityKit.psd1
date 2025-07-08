@{
    # Script module or binary module file associated with this manifest
    RootModule        = 'AIProductivityKit.psm1'
    ModuleVersion     = '1.0.0'
    GUID              = 'a7dd40e4-01b0-4564-9c2c-8a054759e893'
    Author            = 'Doug Finke'
    CompanyName       = ''
    Copyright         = '(c) 2025 Doug Finke. All rights reserved.'
    Description       = 'A collection of powerful, AI-driven utilities designed to supercharge your daily tasks and workflows, all within the familiar and robust environment of PowerShell.'
    PowerShellVersion = '5.1'
    RequiredModules   = @('PSAISuite')
    FunctionsToExport = @(
        'Get-RecentWork'
        'Get-StandUp'
    )
    CmdletsToExport   = @()
    VariablesToExport = @()
    AliasesToExport   = @()
    PrivateData       = @{}
}
