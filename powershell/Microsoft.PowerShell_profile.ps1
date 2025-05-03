if (Get-Module -ListAvailable -Name posh-git) {
    Import-Module posh-git
    $GitPromptSettings.DefaultPromptBeforeSuffix.Text = '`nPS'
}

# Utility functions
# Print all environment variables
function printenv {
    Get-ChildItem env:* | Sort-Object Name
}

# Print all items in PATH
function printpath {
    $env:PATH.split(';') | Sort-Object
}
