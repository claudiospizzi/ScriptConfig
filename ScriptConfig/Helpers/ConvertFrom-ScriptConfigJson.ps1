<#
    .SYNOPSIS
        Convert the JSON file content to a hashtable containing the
        configuration.

    .EXAMPLE
        PS C:\> Get-Content -Path 'config.json' | ConvertFrom-ScriptConfigJson
        Use the pipeline input to parse the JSON file content.

    .LINK
        https://github.com/claudiospizzi/ScriptConfig
#>
function ConvertFrom-ScriptConfigJson
{
    [CmdletBinding()]
    param
    (
        # An array of strings with the JSON file content.
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [System.String[]]
        $Content
    )

    $config = @{}

    try
    {
        # Join all lines into one string and parse the JSON content
        $jsonContent = ($Content -join '') | ConvertFrom-Json

        # Extract all properties from the json content
        $jsonNodes = $jsonContent | Get-Member -MemberType NoteProperty

        foreach ($jsonNode in $jsonNodes)
        {
            $Key   = $jsonNode.Name
            $value = $jsonContent.$Key

            if ($value -is [System.Management.Automation.PSCustomObject])
            {
                $config[$Key] = @{}

                foreach ($property in $value.PSObject.Properties)
                {
                    $config[$Key][$property.Name] = $property.Value
                }
            }
            else
            {
                $config[$Key] = $value
            }
        }

        Write-Output $config
    }
    catch
    {
        throw "The JSON configuration file content was in an invalid format: $_"
    }
}
