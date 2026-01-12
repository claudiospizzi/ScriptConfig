
# Load the default configuration file in XML format
$Config = Get-ScriptConfig -Format 'XML'

# Access the configuration settings
Write-Verbose "String           :" $Config.MyString
Write-Verbose "Integer Positive :" $Config.MyIntegerPositive
Write-Verbose "Integer Negative :" $Config.MyIntegerNegative
Write-Verbose "Boolean True     :" $Config.MyBooleanTrue
Write-Verbose "Boolean False    :" $Config.MyBooleanFalse
Write-Verbose "Array            :" $Config.MyArray
Write-Verbose "Array Item       :" $Config.MyArray[0]
Write-Verbose "Hashtable        :" $Config.MyHashtable
Write-Verbose "Hashtable Item   :" $Config.MyHashtable['Hello']
Write-Verbose "Hashtable Keys   :" $Config.MyHashtable.Keys
Write-Verbose "Hashtable Values :" $Config.MyHashtable.Values
