
$ModulePath = Resolve-Path -Path "$PSScriptRoot\..\..\Modules" | ForEach-Object Path
$ModuleName = Get-ChildItem -Path $ModulePath | Select-Object -First 1 -ExpandProperty BaseName

Remove-Module -Name $ModuleName -Force -ErrorAction SilentlyContinue
Import-Module -Name "$ModulePath\$ModuleName" -Force

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

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini" -Format INI

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

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json" -Format JSON

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

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml" -Format XML

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

    Context 'Format Detection' {

        Mock ConvertFrom-ScriptConfigIni { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigJson { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigXml { return @{} } -ModuleName ScriptConfig

        It 'should call the INI function if a .ini file is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini"

            Assert-MockCalled 'ConvertFrom-ScriptConfigIni' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the JSON function if a .json file is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json"

            Assert-MockCalled 'ConvertFrom-ScriptConfigJson' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the XML function if a .xml file is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml"

            Assert-MockCalled 'ConvertFrom-ScriptConfigXml' -ModuleName ScriptConfig -Times 1 -Exactly
        }
    }

    Context 'Format Parameter' {

        Mock ConvertFrom-ScriptConfigIni { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigJson { return @{} } -ModuleName ScriptConfig
        Mock ConvertFrom-ScriptConfigXml { return @{} } -ModuleName ScriptConfig

        It 'should call the INI function if INI format is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini" -Format INI

            Assert-MockCalled 'ConvertFrom-ScriptConfigIni' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the JSON function if JSON format is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json" -Format JSON

            Assert-MockCalled 'ConvertFrom-ScriptConfigJson' -ModuleName ScriptConfig -Times 1 -Exactly
        }

        It 'should call the XML function if XML format is specified' {

            $Config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml" -Format XML

            Assert-MockCalled 'ConvertFrom-ScriptConfigXml' -ModuleName ScriptConfig -Times 1 -Exactly
        }
    }
}
