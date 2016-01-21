[![Build status](https://ci.appveyor.com/api/projects/status/48di0b0ml0aesj45/branch/master?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/master) [![Build status](https://ci.appveyor.com/api/projects/status/48di0b0ml0aesj45/branch/dev?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/dev)

# ScriptConfig PowerShell Module
PowerShell Module to handle configuration files for PowerShell controller scripts.


## Introduction

With the ScriptConfig module, configuration data can be loaded into a PowerShell script from a file. Thanks to the module, it is no longer necessary to hardcode or paramter-pass the configuration data. Especialy usefull for scripts, which run unattended. The module support `XML`, `JSON` and `INI` formatted config files.


## Requirenments

The following minimum requirenments are necessary to use the module:

* Windows PowerShell 3.0
* Windows Server 2008 R2 / Windows 7


## Installation

Install the module automatically from the [PowerShell Gallery](https://www.powershellgallery.com/packages/ScriptConfig):

```powershell
Install-Module ScriptConfig
```

To install the module mannually, perform the following steps:

1. Download the latest release ([here](https://github.com/claudiospizzi/ScriptConfig/releases)) 
2. Extract the downloaded module into one of the module paths (e.g. `C:\Users\[Usermame]\Documents\WindowsPowerShell\Modules`)


## Cmdlets

Currently, the module has just one single cmdlet, to load the configuration file:

| Cmdlet               | Description                                   |
| -------------------- | --------------------------------------------- |
| `Get-ScriptConfig`   | Loads the configuration from a config file.   |


## Supported Types

The cmdlet supports multiple types. Depending on the used format, the types have to be specified differently inside the config file.

| Type        | Description                                                          |
| ----------- | -------------------------------------------------------------------- |
| String      | Default: A settings is stored as a simple string.                    |
| Integer     | If the setting is an integer, it will be casted this type.           |
| Boolean     | If you specify True or False, it will be casted to a boolean type.   |
| Array       | An array of strings can be specified.                                |
| Hashtable   | A dictionary of key-value-pairs is supported too, both setings.      |


## Supportet Formats

The following formats are suppoted: `XML`, `JSON` and `INI`.

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
