[![AppVeyor - master](https://ci.appveyor.com/api/projects/status/48di0b0ml0aesj45/branch/master?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/master) [![AppVeyor - dev](https://ci.appveyor.com/api/projects/status/48di0b0ml0aesj45/branch/dev?svg=true)](https://ci.appveyor.com/project/claudiospizzi/scriptconfig/branch/dev) [![PowerShell Gallery - ScriptConfig](https://img.shields.io/badge/PowerShell%20Gallery-ScriptConfig-0072C6.svg)](https://www.powershellgallery.com/packages/ScriptConfig)

# ScriptConfig PowerShell Module
PowerShell Module to handle configuration files for PowerShell controller scripts.


## Introduction

With the ScriptConfig module, configuration data can be loaded into a PowerShell controller script from a dedicated config file. Thanks to the module, it is no longer necessary to hardcode or paramter-pass the configuration data. Especialy usefull for scripts, which run unattended. The module support `XML`, `JSON` and `INI` formatted config files. Works great in cooperation with the [ScriptLogger](https://github.com/claudiospizzi/ScriptLogger) module to improve controller scripts.


## Requirenments

The following minimum requirenments are necessary to use the module:

* Windows PowerShell 3.0
* Windows Server 2008 R2 / Windows 7


## Installation

Install the module **automatically** from the [PowerShell Gallery](https://www.powershellgallery.com/packages/ScriptConfig) with PowerShell 5.0:

```powershell
Install-Module ScriptConfig
```

To install the module **manually**, perform the following steps:

1. Download the latest release from [GitHub](https://github.com/claudiospizzi/ScriptConfig/releases) as a ZIP file
2. Extract the downloaded module into one of your module paths ([TechNet: Installing Modules](https://technet.microsoft.com/en-us/library/dd878350))


## Cmdlets

Currently, this module has just one cmdlet, which loads the configuration data from one config file:

| Cmdlet               | Description                                                                                        |
| -------------------- | -------------------------------------------------------------------------------------------------- |
| `Get-ScriptConfig`   | Loads the configuration from a config file. The path and format can be specified with parameters.  |


## Examples

In this example, a `JSON` configuration file is loaded into the script. You will find an example configuration file in the after next chapter. As soon as you have imported the configuration data, you will be able to use the returned object to access the settings with the `.` notation. All available formats for the config files are listed in the next chapter.

```powershell
# Load the configuration from a config file
$Config = Get-ScriptConfig -Path 'C:\Scripts\config.json' -Format JSON

# Access the configuration data from the config variable
Write-Host "Config Data:" $Config.MyString
```


## Supported Types

The cmdlet supports multiple types. Depending on the used format, the types have to be specified differently inside the config file.

| Type          | Description                                                                              |
| ------------- | ---------------------------------------------------------------------------------------- |
| `String`      | A settings is stored as a string by default.                                             |
| `Integer`     | If the setting value is a valid integer, it will be casted into an integer.              |
| `Boolean`     | By specifying the key words `True` or `False`, it will be casted to a boolean type.      |
| `Array`       | An array of strings can be specified.                                                    |
| `Hashtable`   | A dictionary of key-value-pairs is supported too. The key and values will be a string.   |


## Supportet Formats

The following config file formats are suppoted: `XML`, `JSON` and `INI`.

### XML Config File Example

Inside an `XML` formatted config file, it's mandatory to specify the type, the key and the value of each setting. Thanks to this, the config file is type-safe.

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

### JSON Config File Example

With the `JSON` format, it's easy to specify the configuraiton data with less overhead. Because of the special notation, the `JSON` format is also type-safe.

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

### INI Config File Example

The last supported format is the `INI` file. To support all types, it is necessary to extend the basic `INI` file convention with `[` and `]`, to specify arrays and hash tables. Sections are not supported and will be ignored.

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


## Contribute

Please feel free to contribute by opening new issues or providing pull requests.

