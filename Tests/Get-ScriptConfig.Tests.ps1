
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath '..' | Resolve-Path | Select-Object -ExpandProperty Path
$Demo = Join-Path -Path $Root -ChildPath 'Examples' | Resolve-Path | Select-Object -ExpandProperty Path

$Global:PesterDemo = $Demo

Import-Module "$Root\ScriptConfig.psd1" -Force


Describe 'Get-ScriptConfig' {

    Context 'Result' {

        $ResultStringIni       = 'This is a test INI config file!'
        $ResultStringJson      = 'This is a test JSON config file!'
        $ResultStringXml       = 'This is a test XML config file!'
        $ResultIntegerPositive = 42
        $ResultIntegerNegative = -153
        $ResultBooleanTrue     = $true
        $ResultBooleanFalse    = $false
        $ResultArray           = @( 'Lorem', 'Ipsum' )
        $ResultHashtable       = @{ Foo = 'Bar'; Hello = 'World' }

        It 'shloud be able to load a valid INI configuration file' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\IniConfigDemo.ps1.config" -Format INI

            $Config | Should Not BeNullOrEmpty

            $Config.MyString           | Should Be $ResultStringIni
            $Config.MyIntegerPositive  | Should Be $ResultIntegerPositive
            $Config.MyIntegerNegative  | Should Be $ResultIntegerNegative
            $Config.MyBooleanTrue      | Should Be $ResultBooleanTrue
            $Config.MyBooleanFalse     | Should Be $ResultBooleanFalse
            $Config.MyArray            | Should Be $ResultArray
            $Config.MyHashtable.Keys   | Should Be $ResultHashtable.Keys
            $Config.MyHashtable.Values | Should Be $ResultHashtable.Values
        }

        It 'shloud be able to load a valid JSON configuration file' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\JsonConfigDemo.ps1.config" -Format JSON

            $Config | Should Not BeNullOrEmpty

            $Config.MyString           | Should Be $ResultStringJson
            $Config.MyIntegerPositive  | Should Be $ResultIntegerPositive
            $Config.MyIntegerNegative  | Should Be $ResultIntegerNegative
            $Config.MyBooleanTrue      | Should Be $ResultBooleanTrue
            $Config.MyBooleanFalse     | Should Be $ResultBooleanFalse
            $Config.MyArray            | Should Be $ResultArray
            $Config.MyHashtable.Keys   | Should Be $ResultHashtable.Keys
            $Config.MyHashtable.Values | Should Be $ResultHashtable.Values
        }

        It 'shloud be able to load a valid XML configuration file' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\XmlConfigDemo.ps1.config" -Format XML

            $Config | Should Not BeNullOrEmpty

            $Config.MyString           | Should Be $ResultStringXml
            $Config.MyIntegerPositive  | Should Be $ResultIntegerPositive
            $Config.MyIntegerNegative  | Should Be $ResultIntegerNegative
            $Config.MyBooleanTrue      | Should Be $ResultBooleanTrue
            $Config.MyBooleanFalse     | Should Be $ResultBooleanFalse
            $Config.MyArray            | Should Be $ResultArray
            $Config.MyHashtable.Keys   | Should Be $ResultHashtable.Keys
            $Config.MyHashtable.Values | Should Be $ResultHashtable.Values
        }
    }

    Context 'Format' {

        Mock ConvertFrom-ScriptConfigIni { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigJson { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigXml { return @{} } -ModuleName ScriptConfig

        It 'should call the INI function if INI foramt is specified' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\IniConfigDemo.ps1.config" -Format INI

            Assert-MockCalled 'ConvertFrom-ScriptConfigIni' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the JSON function if JSON foramt is specified' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\JsonConfigDemo.ps1.config" -Format JSON

            Assert-MockCalled 'ConvertFrom-ScriptConfigJson' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the XML function if XML foramt is specified' {

            $Config = Get-ScriptConfig -Path "$Global:PesterDemo\XmlConfigDemo.ps1.config" -Format XML

            Assert-MockCalled 'ConvertFrom-ScriptConfigXml' -ModuleName ScriptConfig -Times 1 -Exactly
        }
    }
}
