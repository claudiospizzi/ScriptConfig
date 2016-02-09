<#
.SYNOPSIS
    Convert the XML file content to a hashtable containing the configuration.

.DESCRIPTION
    Convert the XML file content to a hashtable containing the configuration.

.PARAMETER Content
    An array of strings with the XML file content. Each array item is a line.

.EXAMPLE
    C:\> Get-Content -Path 'config.xml' | ConvertFrom-ScriptConfigXml
    Use the pipeline input to parse the XML file content.

.NOTES
    Author     : Claudio Spizzi
    License    : MIT License

.LINK
    https://github.com/claudiospizzi/ScriptConfig
#>

function ConvertFrom-ScriptConfigXml
{
    [CmdletBinding()]
    param
    (
        [Parameter(Position=0,
                   Mandatory=$true,
                   ValueFromPipeline=$true)]
        [AllowEmptyString()]
        [String[]] $Content
    )

    Write-Verbose "Parse script configuration file as XML format ..."
    
    $Config = @{}

    try
    {
        # Try to cast the content into an XmlDocument
        $XmlContent = [Xml] $Content

        # Extract all setting objects
        $Settings = $XmlContent.Configuration.Settings.Setting

        foreach ($Setting in $Settings)
        {
            switch ($Setting.Type)
            {
                # String
                'string' {
                    $Config[$Setting.Key] = $Setting.Value
                }

                # Integer
                'integer' {
                    $Config[$Setting.Key] = [Int32]::Parse($Setting.Value)
                }

                # Boolean
                'boolean' {
                    $Config[$Setting.Key] = 'True' -eq $Setting.Value
                }

                # Array
                'array' {
                    $Config[$Setting.Key] = @()
                    foreach ($Item in $Setting.Item)
                    {
                        $Config[$Setting.Key] += $Item.Value
                    }
                }

                # Hashtable
                'hashtable' {
                    $Config[$Setting.Key] = @{}
                    foreach ($Item in $Setting.Item)
                    {
                        $Config[$Setting.Key][$Item.Key] = $Item.Value
                    }
                }
            }
        }

        Write-Output $Config
    }
    catch
    {
        throw "The configuration file content was in an invalid format: $_"
    }
}
