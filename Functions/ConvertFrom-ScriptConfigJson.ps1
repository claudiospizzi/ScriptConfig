<#
.SYNOPSIS
    Convert the JSON file content to a hashtable containing the configuration.

.DESCRIPTION
    Convert the JSON file content to a hashtable containing the configuration.

.PARAMETER Content
    An array of strings with the JSON file content. Each array item is a line.

.EXAMPLE
    C:\> Get-Content -Path 'config.json' | ConvertFrom-ScriptConfigJson
    Use the pipeline input to parse the JSON file content.
#>

function ConvertFrom-ScriptConfigJson
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

    Write-Verbose "Parse script configuration file as JSON format ..."

    $Config = @{}

    try
    {
        # Join all lines into one string
        $Content = $Content -join ''

        # Parse the JSON content
        $JsonContent = $Content | ConvertFrom-Json 

        # Extract all propeties from the json content
        $JsonNodes = $JsonContent | Get-Member -MemberType NoteProperty

        foreach ($JsonNode in $JsonNodes)
        {
            $Key   = $JsonNode.Name
            $Value = $JsonContent.$Key

            # Hashtable / Other
            if ($Value -is [System.Management.Automation.PSCustomObject])
            {
                $Config[$Key] = @{}

                foreach ($Property in $Value.PSObject.Properties)
                {
                    $Config[$Key][$Property.Name] = $Property.Value
                }
            }
            else
            {
                $Config[$Key] = $Value
            }
        }

        Write-Output $Config
    }
    catch
    {
        throw "The configuration file content was in an invalid format: $_"
    }
}
