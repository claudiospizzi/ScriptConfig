
# Load the default configuration file in INI format
$Config = Get-ScriptConfig -Format INI

# Access the configuration settings
Write-Host "String           :" $Config.MyString
Write-Host "Integer Positive :" $Config.MyIntegerPositive
Write-Host "Integer Negative :" $Config.MyIntegerNegative
Write-Host "Boolean True     :" $Config.MyBooleanTrue
Write-Host "Boolean False    :" $Config.MyBooleanFalse
Write-Host "Array            :" "@(" (($Config.MyArray | ForEach-Object { '"{0}"' -f $_ }) -join ', ') ")"
Write-Host "Hashtable        :" "@{" (($Config.MyHashtable.GetEnumerator() | ForEach-Object { '{0} = "{1}"' -f $_.Name, $_.Value }) -join '; ') "}"
