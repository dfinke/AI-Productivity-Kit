# AIProductivityKit.psm1
# Exports all public functions

# Dot-source all scripts in the Public folder

$publicScripts = Get-ChildItem -Path $PSScriptRoot\Public -Filter '*.ps1' -File
foreach ($script in $publicScripts) {
    . $script.FullName
}

