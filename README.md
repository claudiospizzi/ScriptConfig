[![AppVeyor - master](https://img.shields.io/appveyor/ci/claudiospizzi/ScriptConfig/master.svg)](https://ci.appveyor.com/project/claudiospizzi/ScriptConfig/branch/master)
[![AppVeyor - dev](https://img.shields.io/appveyor/ci/claudiospizzi/ScriptConfig/dev.svg)](https://ci.appveyor.com/project/claudiospizzi/ScriptConfig/branch/dev)
[![GitHub - Release](https://img.shields.io/github/release/claudiospizzi/ScriptConfig.svg)](https://github.com/claudiospizzi/ScriptConfig/releases)
[![PowerShell Gallery - ScriptConfig](https://img.shields.io/badge/PowerShell_Gallery-ScriptConfig-0072C6.svg)](https://www.powershellgallery.com/packages/ScriptConfig)


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


## Requirements

The following minimum requirements are necessary to use this module:

* Windows PowerShell 3.0
* Windows Server 2008 R2 / Windows 7


## Installation

With PowerShell 5.0, the new [PowerShell Gallery] was introduced. Additionally,
the new module [PowerShellGet] was added to the default WMF 5.0 installation.
With the cmdlet `Install-Module`, a published module from the PowerShell Gallery
can be downloaded and installed directly within the PowerShell host, optionally
with the scope definition:

```powershell
Install-Module ScriptConfig [-Scope {CurrentUser | AllUsers}]
```

Alternatively, download the latest release from GitHub and install the module
manually on your local system:

1. Download the latest release from GitHub as a ZIP file: [GitHub Releases]
2. Extract the module and install it: [Installing a PowerShell Module]


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

### 2.0.0

- Convert module to new deployment model
- Rework code against high quality module guidelines by Microsoft
- BREAKING CHANGE: Remove positional parameters

### 1.0.3

- Add formats and types resources

### 1.0.2

- Fix default path issue for Get-ScriptConfig

### 1.0.1

- Update file encoding to UTF8 w/o BOM
- Enhance parameters for Get-ScriptConfig function
- Update demo and help

### 1.0.0

- Initial public release


## Contribute

Please feel free to contribute by opening new issues or providing pull requests.
For the best development experience, open this project as a folder in Visual
Studio Code and ensure that the PowerShell extension is installed.

* [Visual Studio Code]
* [PowerShell Extension]

This module is tested with the PowerShell testing framework Pester. To run all
tests, just start the included test script `.\Scripts\test.ps1` or invoke Pester
directly with the `Invoke-Pester` cmdlet. The tests will automatically download
the latest meta test from the claudiospizzi/PowerShellModuleBase repository.

To debug the module, just copy the existing `.\Scripts\debug.default.ps1` file
to `.\Scripts\debug.ps1`, which is ignored by git. Now add the command to the
debug file and start it.



[ScriptLogger]: https://github.com/claudiospizzi/ScriptLogger 

[PowerShell Gallery]: https://www.powershellgallery.com/packages/ScriptConfig
[PowerShellGet]: https://technet.microsoft.com/en-us/library/dn807169.aspx

[GitHub Releases]: https://github.com/claudiospizzi/ScriptConfig/releases
[Installing a PowerShell Module]: https://msdn.microsoft.com/en-us/library/dd878350

[Visual Studio Code]: https://code.visualstudio.com/
[PowerShell Extension]: https://marketplace.visualstudio.com/items?itemName=ms-vscode.PowerShell
