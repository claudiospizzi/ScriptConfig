<#
.SYNOPSIS
    Convert the INI file content to a hashtable containing the configuration.

.DESCRIPTION
    Convert the INI file content to a hashtable containing the configuration.

.PARAMETER Content
    An array of strings with the INI file content. Each array item is a line.

.EXAMPLE
    C:\> Get-Content -Path 'config.ini' | ConvertFrom-ScriptConfigIni
    Use the pipeline input to parse the INI file content.
#>

function ConvertFrom-ScriptConfigIni
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

    Write-Verbose "Parse script configuration file as INI format ..."

    $Config = @{}

    try
    {
        # Iterating each line and parse the setting
        foreach ($Line in $Content)
        {
            switch -Wildcard ($Line)
            {
                # Comment
                ';*' {

                    break
                }

                # Array
                '*`[`]=*'{
                    $Key   = $Line.Split('[]=', 4)[0]
                    $Value = $Line.Split('[]=', 4)[3]

                    if ($null -eq $Config[$Key])
                    {
                        $Config[$Key] = @()
                    }

                    $Config[$Key] += $Value

                    break
                }

                # Hashtable
                '*`[*`]=*' {
                    $Key   = $Line.Split('[]=', 4)[0]
                    $Hash  = $Line.Split('[]=', 4)[1]
                    $Value = $Line.Split('[]=', 4)[3]

                    if ($null -eq $Config[$Key])
                    {
                        $Config[$Key] = @{}
                    }

                    $Config[$Key][$Hash] = $Value

                    break
                }

                # String, Integer or Boolean
                '*=*' {
                    $Key   = $Line.Split('=', 2)[0]
                    $Value = $Line.Split('=', 2)[1]

                    try { $Value = [Int32]::Parse($Value) } catch { }

                    if ('True'.Equals($Value)) { $Value = $true }
                    if ('False'.Equals($Value)) { $Value = $false }

                    $Config[$Key] = $Value

                    break
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
