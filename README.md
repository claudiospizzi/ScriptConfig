[![PowerShell Gallery - ScriptConfig](https://img.shields.io/badge/PowerShell_Gallery-ScriptConfig-0072C6.svg)](https://www.powershellgallery.com/packages/ScriptConfig)
[![GitHub - Release](https://img.shields.io/github/release/claudiospizzi/ScriptConfig.svg)](https://github.com/claudiospizzi/ScriptConfig/releases)
[![AppVeyor - master](https://img.shields.io/appveyor/ci/claudiospizzi/ScriptConfig/master.svg)](https://ci.appveyor.com/project/claudiospizzi/ScriptConfig/branch/master)
[![AppVeyor - dev](https://img.shields.io/appveyor/ci/claudiospizzi/ScriptConfig/dev.svg)](https://ci.appveyor.com/project/claudiospizzi/ScriptConfig/branch/dev)


# ScriptConfig PowerShell Module

PowerShell Module to handle configuration files for PowerShell controller
scripts.


## Introduction

With the ScriptConfig module, configuration data can be loaded into a PowerShell
controller script from a dedicated config file. Thanks to the module, it is no
longer necessary to hard-code or paramter-pass the configuration data.
Especially useful for scripts, which run unattended. The module support `XML`,
`JSON` and `INI` formatted config files. Works great in cooperation with the
[ScriptLogger] module to improve controller scripts.


## Features

* **Get-ScriptConfig**  
  Loads the configuration from a config file. The path and format can be
  specified with parameters.


### Example

In this example, a `JSON` configuration file is loaded into the script. You will
find an example configuration file in the after next chapter. As soon as you
have imported the configuration data, you will be able to use the returned
object to access the settings with the `.` notation. All available formats for
the config files are listed in the next chapter.

```powershell
# Load the configuration from a config file
$config = Get-ScriptConfig -Path 'C:\Scripts\config.json' -Format JSON

# Access the configuration data from the config variable
Write-Host "Config Data:" $config.MyString
```


### Supported Types

The cmdlet supports multiple types. Depending on the used format, the types have
to be specified differently inside the config file.

| Type          | Description                                                                              |
| ------------- | ---------------------------------------------------------------------------------------- |
| `String`      | A settings is stored as a string by default.                                             |
| `Integer`     | If the setting value is a valid integer, it will be casted into an integer.              |
| `Boolean`     | By specifying the key words `True` or `False`, it will be casted to a boolean type.      |
| `Array`       | An array of strings can be specified.                                                    |
| `Hashtable`   | A dictionary of key-value-pairs is supported too. The key and values will be a string.   |


### XML Format

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


### JSON Format

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


### INI Format

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


## Versions

Please find all versions in the [GitHub Releases] section and the release notes
in the [CHANGELOG.md] file.


## Installation

Use the following command to install the module from the [PowerShell Gallery],
if the PackageManagement and PowerShellGet modules are available:

```powershell
# Download and install the module
Install-Module -Name 'ScriptConfig'
```

Alternatively, download the latest release from GitHub and install the module
manually on your local system:

1. Download the latest release from GitHub as a ZIP file: [GitHub Releases]
2. Extract the module and install it: [Installing a PowerShell Module]


## Requirements

The following minimum requirements are necessary to use this module:

* Windows PowerShell 3.0
* Windows Server 2008 R2 / Windows 7


## Contribute

Please feel free to contribute by opening new issues or providing pull requests.
For the best development experience, open this project as a folder in Visual
Studio Code and ensure that the PowerShell extension is installed.

* [Visual Studio Code] with the [PowerShell Extension]
* [Pester], [PSScriptAnalyzer] and [psake] PowerShell Modules



[ScriptLogger]: https://github.com/claudiospizzi/ScriptLogger

[PowerShell Gallery]: https://www.powershellgallery.com/packages/ScriptConfig
[GitHub Releases]: https://github.com/claudiospizzi/ScriptConfig/releases
[Installing a PowerShell Module]: https://msdn.microsoft.com/en-us/library/dd878350

[CHANGELOG.md]: CHANGELOG.md

[Visual Studio Code]: https://code.visualstudio.com/
[PowerShell Extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
[Pester]: https://www.powershellgallery.com/packages/Pester
[PSScriptAnalyzer]: https://www.powershellgallery.com/packages/PSScriptAnalyzer
[psake]: https://www.powershellgallery.com/packages/psake
