@{
    RootModule         = 'ScriptConfig.psm1'
    ModuleVersion      = '1.0.1'
    GUID               = '0464897C-2F37-489F-93B2-7F6B9B582761'
    Author             = 'Claudio Spizzi'
    Copyright          = 'Copyright (c) 2016 by Claudio Spizzi. Licensed under MIT license.'
    Description        = 'PowerShell Module to handle configuration files for PowerShell Controller Scripts.'
    PowerShellVersion  = '3.0'
    ScriptsToProcess   = @()
    TypesToProcess     = @()
    FormatsToProcess   = @()
    FunctionsToExport  = @(
        'Get-ScriptConfig'
    )
    CmdletsToExport    = @()
    VariablesToExport  = @()
    AliasesToExport    = @()
    PrivateData        = @{
        PSData             = @{
            Tags               = @('PSModule', 'Config', 'Configuration', 'Script', 'Controller')
            LicenseUri         = 'https://raw.githubusercontent.com/claudiospizzi/ScriptConfig/master/LICENSE'
            ProjectUri         = 'https://github.com/claudiospizzi/ScriptConfig'
        }
    }
}
