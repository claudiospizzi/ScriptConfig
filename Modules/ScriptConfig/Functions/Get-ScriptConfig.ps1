<#
    .SYNOPSIS
    Load a script configuration from a config file.

    .DESCRIPTION
    Load a script configuration from a config file. By default, the config file
    next to the script is loaded. So for the script MyScript.ps1, the config
    file MyScript.ps1.config will be loaded. The config file format will be
    detected by it's extension (.xml, .ini, .json). If the file format can't be
    detected, the default format (XML) will be used.

    .EXAMPLE
    PS C:\> $config = Get-ScriptConfig
    Loads the default XML formatted configuration file.

    .EXAMPLE
    PS C:\> $config = Get-ScriptConfig -Path 'C:\MyApp\global.config'
    Loads a custom configuration file, with default XML format.

    .EXAMPLE
    PS C:\> $config = Get-ScriptConfig -Format JSON
    Loads the default configuration file but in JSON format.

    .NOTES
    Author     : Claudio Spizzi
    License    : MIT License

    .LINK
    https://github.com/claudiospizzi/ScriptConfig
#>

function Get-ScriptConfig
{
    [CmdletBinding()]
    param
    (
        # Specify the path to the configuration file. By default, the current
        # script file path will be used with an appended '.config' extension.
        [Parameter(Mandatory = $false)]
        [ValidateScript({Test-Path -Path $_})]
        [System.String]
        $Path = ([String] $Global:MyInvocation.MyCommand.Definition).Trim() + '.config',

        # Override the format detection and default value.
        [Parameter(Mandatory = $false)]
        [ValidateSet('XML', 'JSON', 'INI')]
        [System.String]
        $Format
    )

    # Only work with absolute path, makes error handling easier
    $Path = (Resolve-Path -Path $Path).Path

    # If no format was specified, try to detect it
    if ([String]::IsNullOrEmpty($Format))
    {
        switch -Wildcard ($Path)
        {
            '*.xml'  { $Format = 'XML' }
            '*.json' { $Format = 'JSON' }
            '*.ini'  { $Format = 'INI' }
            default  { $Format = 'XML' }
        }
    }

    Write-Verbose "Load script configuration from file $Path with format $Format"

    # Load raw content, parse it later
    $content = Get-Content -Path $Path -ErrorAction Stop

    # Use custom functions to parse the files
    switch ($Format)
    {
        'XML'  { $configHashtable = ConvertFrom-ScriptConfigXml -Content $content  }
        'JSON' { $configHashtable = ConvertFrom-ScriptConfigJson -Content $content }
        'INI'  { $configHashtable = ConvertFrom-ScriptConfigIni -Content $content  }
    }

    # Create a config object with a custom type
    $config = New-Object -TypeName PSObject -Property $configHashtable
    $config.PSTypeNames.Insert(0, 'ScriptConfig.Configuration')

    Write-Output $config
}
