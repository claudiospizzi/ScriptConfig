[CmdletBinding()]
[Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingWriteHost', '', Justification = 'Integration test output')]
param ()

# Load the default configuration file in XML format
$Config = Get-ScriptConfig -Format 'XML'

# Access the configuration settings
Write-Host "String           :" $Config.MyString
Write-Host "Integer Positive :" $Config.MyIntegerPositive
Write-Host "Integer Negative :" $Config.MyIntegerNegative
Write-Host "Boolean True     :" $Config.MyBooleanTrue
Write-Host "Boolean False    :" $Config.MyBooleanFalse
Write-Host "Array            :" $Config.MyArray
Write-Host "Array Item       :" $Config.MyArray[0]
Write-Host "Hashtable        :" $Config.MyHashtable
Write-Host "Hashtable Item   :" $Config.MyHashtable['Hello']
Write-Host "Hashtable Keys   :" $Config.MyHashtable.Keys
Write-Host "Hashtable Values :" $Config.MyHashtable.Values
