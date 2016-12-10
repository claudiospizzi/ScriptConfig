
# Load the default configuration file in INI format
$Config = Get-ScriptConfig -Format INI

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
