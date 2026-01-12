<#
    .SYNOPSIS
        Load a script configuration from a config file.

    .DESCRIPTION
        Load a script configuration from a config file. By default, the config
        file next to the script is loaded. So for the script MyScript.ps1, the
        config file MyScript.ps1.config will be loaded. The config file format
        will be detected by it's extension (.xml, .ini, .json). If the file
        format can't be detected, the default format (JSON) will be used.

    .EXAMPLE
        PS C:\> $config = Get-ScriptConfig
        Loads the default JSON formatted configuration file.

    .EXAMPLE
        PS C:\> $config = Get-ScriptConfig -Path 'C:\MyApp\global.config'
        Loads a custom configuration file, with default JSON format.

    .EXAMPLE
        PS C:\> $config = Get-ScriptConfig -Format XML
        Loads the default configuration file but in XML format.

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
        [AllowEmptyString()]
        [System.String]
        $Path,

        # Override the format detection and default value.
        [Parameter(Mandatory = $false)]
        [ValidateSet('XML', 'JSON', 'INI')]
        [System.String]
        $Format
    )

    # If the Path parameter was not specified, add a default value. If possible,
    # use the last script called this function. Else throw an exception.
    if (-not $PSBoundParameters.ContainsKey('Path') -or [System.String]::IsNullOrEmpty($Path))
    {
        $lastScriptPath = Get-PSCallStack | Select-Object -Skip 1 -First 1 -ExpandProperty 'ScriptName'

        if (-not [System.String]::IsNullOrEmpty($lastScriptPath))
        {
            if (Test-Path -Path "$lastScriptPath.ini")
            {
                $Path = "$lastScriptPath.ini"
            }
            elseif (Test-Path -Path "$lastScriptPath.json")
            {
                $Path = "$lastScriptPath.json"
            }
            elseif (Test-Path -Path "$lastScriptPath.xml")
            {
                $Path = "$lastScriptPath.xml"
            }
            else
            {
                $Path = "$lastScriptPath.config"
            }
        }
        else
        {
            throw "Configuration file not specified"
        }
    }

    # Now check, if the configuration file exists
    if (-not (Test-Path -Path $Path))
    {
        throw "Configuration file not found: $Path"
    }

    # If the Format parameter was not specified, try to detect by the file
    # extension or use the default format JSON.
    if (-not $PSBoundParameters.ContainsKey('Format'))
    {
        switch -Wildcard ($Path)
        {
            '*.ini'  { $Format = 'INI' }
            '*.json' { $Format = 'JSON' }
            '*.xml'  { $Format = 'XML' }
            default  { $Format = 'JSON' }
        }
    }

    Write-Verbose "Load script configuration from file $Path with format $Format"

    # Load raw content, parse it later
    $content = Get-Content -Path $Path -ErrorAction Stop

    # Use custom functions to parse the files and return the config object
    switch ($Format)
    {
        'XML'  { ConvertFrom-ScriptConfigXml -Content $content }
        'JSON' { ConvertFrom-ScriptConfigJson -Content $content }
        'INI'  { ConvertFrom-ScriptConfigIni -Content $content }
    }
}
