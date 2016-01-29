<#
.SYNOPSIS
    Load a script configuration from a config file.

.DESCRIPTION
    Load a script configuration from a config file. By default, the config file
    next to the script is loaded. So for the script MyScript.ps1, the config
    file MyScript.ps1.config will be loaded. By default, the script should be
    in XML format.

.PARAMETER Path
    You can override the default dynamic config file path with this parameter.

.PARAMETER Format
    The default format is XML. You can override the format with this parameter.

.EXAMPLE
    C:\> $Config = Get-ScriptConfig
    Loads the default XML formatted configuration file.

.EXAMPLE
    C:\> $Config = Get-ScriptConfig -Path 'C:\MyApp\global.config'
    Loads a custom configuration file, with default XML format.

.EXAMPLE
    C:\> $Config = Get-ScriptConfig -Format JSON
    Loads the default configuration file but in JSON format.
#>

function Get-ScriptConfig
{
    [CmdletBinding()]
    param
    (
        [Parameter(Position=0,
                   Mandatory=$false)]
        [ValidateScript({Test-Path -Path $_})]
        [String] $Path = $Global:MyInvocation.MyCommand.Definition.Trim() + '.config',

        [Parameter(Position=1,
                   Mandatory=$false)]
        [ValidateSet('XML', 'JSON', 'INI')]
        [String] $Format = 'XML'
    )

    # Only work with absolute path, makes error handling easier
    $Path = (Resolve-Path -Path $Path).Path

    Write-Verbose "Load script configuration from file $Path ..."

    # Load raw content, parse it later
    $Content = Get-Content -Path $Path -ErrorAction Stop

    # Use custom functions to parse the files
    switch ($Format)
    {
        'XML' {
            $ConfigHashtable = ConvertFrom-ScriptConfigXml -Content $Content
        }

        'JSON' {
            $ConfigHashtable = ConvertFrom-ScriptConfigJson -Content $Content
        }

        'INI' {
            $ConfigHashtable = ConvertFrom-ScriptConfigIni -Content $Content
        }
    }

    # Create a config object with a custom type
    $Config = New-Object -TypeName PSObject -Property $ConfigHashtable
    $Config.PSTypeNames.Insert(0, 'ScriptConfig.Configuration')

    Write-Output $Config
}
