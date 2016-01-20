![Build status](https://ci.appveyor.com/api/projects/status/p3qiywni2t288473/branch/master?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/master) ![Build status](https://ci.appveyor.com/api/projects/status/p3qiywni2t288473/branch/dev?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/dev)

# ScriptConfig PowerShell Module
PowerShell Module to handle configuration files for PowerShell Controller Scripts.

## Introduction

With the ScriptConfig module, configuration data can be loaded inside a PowerShell script from a configuration file. Thanks to the module, it is no longer necessary to hardcode or paramter-pass the configuration data. Especialy usefull for scripts, which run unattended. The module support XML, JSON and INI format.


## Requirenments

The following minimum requirenments are necessary, to use the module:

* Windows PowerShell 3.0
* Windows Server 2008 R2 / Windows 7


## Installation

Install the module automatically from the [PowerShell Gallery](https://www.powershellgallery.com/packages/ScriptConfig):

```powershell
Install-Module ScriptConfig
```

To install the module mannually, perform the following steps:

1. Download the latest release ([here](https://github.com/claudiospizzi/ScriptConfig/releases)) 
2. Extract the downloaded module to one of the module paths:
   C:\Users\Claudio\Documents\WindowsPowerShell\Modules
    C:\Program Files\WindowsPowerShell\Modules
    C:\Windows\system32\WindowsPowerShell\v1.0\Modules

	
## Cmdlets

Currently, the module has just one cmdlet to load the configuration file:

| Cmdlet             | Description                                   |
| ------------------ | --------------------------------------------- |
| Get-ScriptConfig   | Loads the configuration from a config file.   |


## Supported Types

The cmdlet supports multiple types. Depending on the format, the have to be specified differently.

| Type        | Description                                                       |
| ----------- | ----------------------------------------------------------------- |
| String      | A settings is stored as a simple string by default.               |
| Integer     | If the setting is an integer, it will be casted to it.            |
| Boolean     | If you specify True or False, it will be returned as a boolean.   |
| Array       | An array of strings can be specified.                             |
| Hashtable   | A dictionary of key-value-pairs is supported too.                 |


## Supportet Formats

### XML

```xml
<?xml version="1.0" encoding="utf-8"?>
<Configuration>
    <Settings>
        <Setting Type="string" Key="MyString" Value="This is a test XML config file!" />
        <Setting Type="integer" Key="MyIntegerPositive" Value="42" />
        <Setting Type="integer" Key="MyIntegerNegative" Value="-153" />
        <Setting Type="boolean" Key="MyBooleanTrue" Value="true" />
        <Setting Type="boolean" Key="MyBooleanFalse" Value="false" />
        <Setting Type="array" Key="MyArray">
            <Item Value="Lorem" />
            <Item Value="Ipsum" />
        </Setting>
        <Setting Type="hashtable" Key="MyHashtable">
            <Item Key="Foo" Value="Bar" />
            <Item Key="Hello" Value="World" />
        </Setting>
    </Settings>
</Configuration>

```

### JSON

```json
{
    "MyString":  "This is a test JSON config file!",
    "MyIntegerPositive":  42,
    "MyIntegerNegative":  -153,
    "MyBooleanTrue":  true,
    "MyBooleanFalse":  false,
    "MyArray":  [
                    "Lorem",
                    "Ipsum"
                ],
    "MyHashtable":  {
                        "Foo": "Bar",
                        "Hello": "World"
                    }
}

```

### INI

```ini
MyString=This is a test INI config file!
MyIntegerPositive=42
MyIntegerNegative=-153
MyBooleanTrue=True
MyBooleanFalse=False
MyArray[]=Lorem
MyArray[]=Ipsum
MyHashtable[Foo]=Bar
MyHashtable[Hello]=World
```
