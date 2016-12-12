@{
    RootModule         = 'ScriptConfig.psm1'
    ModuleVersion      = '2.0.0'
    GUID               = '0464897C-2F37-489F-93B2-7F6B9B582761'
    Author             = 'Claudio Spizzi'
    Copyright          = 'Copyright (c) 2016 by Claudio Spizzi. Licensed under MIT license.'
    Description        = 'PowerShell Module to handle configuration files for PowerShell controller scripts.'
    PowerShellVersion  = '3.0'
    RequiredModules    = @()
    RequiredAssemblies = @()
    ScriptsToProcess   = @()
    TypesToProcess     = @(
        'Resources\ScriptConfig.Types.ps1xml'
    )
    FormatsToProcess   = @(
        'Resources\ScriptConfig.Formats.ps1xml'
    )
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
            ExternalModuleDependencies = @()
        }
    }
}
