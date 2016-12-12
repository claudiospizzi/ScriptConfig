<#
    .SYNOPSIS
    Convert the XML file content to a hashtable containing the configuration.

    .EXAMPLE
    PS C:\> Get-Content -Path 'config.xml' | ConvertFrom-ScriptConfigXml
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
        # An array of strings with the XML file content.
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [System.String[]]
        $Content
    )

    $config = @{}

    try
    {
        # Try to cast the content into an XmlDocument
        $xmlContent = [Xml] $Content

        # Extract all setting objects
        $settings = $xmlContent.Configuration.Settings.Setting

        foreach ($setting in $settings)
        {
            switch ($setting.Type)
            {
                # String
                'string' {
                    $config[$setting.Key] = $setting.Value
                }

                # Integer
                'integer' {
                    $config[$setting.Key] = [Int32]::Parse($setting.Value)
                }

                # Boolean
                'boolean' {
                    $config[$setting.Key] = 'True' -eq $setting.Value
                }

                # Array
                'array' {
                    $config[$setting.Key] = @()
                    foreach ($item in $setting.Item)
                    {
                        $config[$setting.Key] += $item.Value
                    }
                }

                # Hashtable
                'hashtable' {
                    $config[$setting.Key] = @{}
                    foreach ($item in $setting.Item)
                    {
                        $config[$setting.Key][$item.Key] = $item.Value
                    }
                }
            }
        }

        Write-Output $config
    }
    catch
    {
        throw "The XML configuration file content was in an invalid format: $_"
    }
}
