<#
    .SYNOPSIS
        Convert the INI file content to a hashtable containing the
        configuration.

    .EXAMPLE
        PS C:\> Get-Content -Path 'config.ini' | ConvertFrom-ScriptConfigIni
        Use the pipeline input to parse the INI file content.

    .NOTES
        Author     : Claudio Spizzi
        License    : MIT License

    .LINK
        https://github.com/claudiospizzi/ScriptConfig
#>
function ConvertFrom-ScriptConfigIni
{
    [CmdletBinding()]
    param
    (
        # An array of strings with the INI file content.
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [AllowEmptyString()]
        [System.String[]]
        $Content
    )

    $config = @{
        PSTypeName = 'ScriptConfig.Configuration'
    }

    try
    {
        # Iterating each line and parse the setting
        foreach ($line in $Content)
        {
            switch -Wildcard ($line)
            {
                # Comment
                ';*' {
                    break
                }

                # Section
                '`[*`]*' {
                    break
                }

                # Array
                '*`[`]=*'{
                    $key   = $line.Split('[]=', 4)[0]
                    $value = $line.Split('[]=', 4)[3]

                    if ($null -eq $config[$key])
                    {
                        $config[$key] = @()
                    }

                    $config[$key] += $value

                    break
                }

                # Hashtable
                '*`[*`]=*' {
                    $key   = $line.Split('[]=', 4)[0]
                    $hash  = $line.Split('[]=', 4)[1]
                    $value = $line.Split('[]=', 4)[3]

                    if ($null -eq $config[$key])
                    {
                        $config[$key] = @{}
                    }

                    $config[$key][$hash] = $value

                    break
                }

                # String, Integer or Boolean
                '*=*' {
                    $key   = $line.Split('=', 2)[0]
                    $value = $line.Split('=', 2)[1]

                    [Int32] $valueInt = $null
                    if (([Int32]::TryParse($value, [ref] $valueInt)))
                    {
                        $config[$key] = $valueInt
                    }
                    else
                    {
                        if ('True'.Equals($value)) { $value = $true }
                        if ('False'.Equals($value)) { $value = $false }

                        $config[$key] = $value
                    }

                    break
                }
            }
        }

        [PSCustomObject] $config
    }
    catch
    {
        throw "The INI configuration file content was in an invalid format: $_"
    }
}
