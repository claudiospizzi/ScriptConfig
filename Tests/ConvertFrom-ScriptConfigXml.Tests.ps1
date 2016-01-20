
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath '..' | Resolve-Path | Select-Object -ExpandProperty Path
$Demo = Join-Path -Path $Root -ChildPath 'Examples' | Resolve-Path | Select-Object -ExpandProperty Path

$Global:PesterDemo = $Demo

Import-Module "$Root\ScriptConfig.psd1" -Force


InModuleScope ScriptConfig {

    Describe 'ConvertFrom-ScriptConfigXml' {

        $ResultString          = 'This is a test XML config file!'
        $ResultIntegerPositive = 42
        $ResultIntegerNegative = -153
        $ResultBooleanTrue     = $true
        $ResultBooleanFalse    = $false
        $ResultArray           = @( 'Lorem', 'Ipsum' )
        $ResultHashtable       = @{ Foo = 'Bar'; Hello = 'World' }

        $Content = Get-Content -Path "$Global:PesterDemo\XmlConfigDemo.ps1.config"

        It 'should be able to convert the example config file' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config | Should Not BeNullOrEmpty
        }

        It 'shloud be able to parse a string' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config.MyString           | Should Be $ResultString
            $Config.MyString.GetType() | Should Be ([System.String])
        }

        It 'shloud be able to parse an integer' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config.MyIntegerPositive           | Should Be $ResultIntegerPositive
            $Config.MyIntegerPositive.GetType() | Should Be ([System.Int32])

            $Config.MyIntegerNegative           | Should Be $ResultIntegerNegative
            $Config.MyIntegerNegative.GetType() | Should Be ([System.Int32])
        }

        It 'shloud be able to parse an boolean' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config.MyBooleanTrue           | Should Be $ResultBooleanTrue
            $Config.MyBooleanTrue.GetType() | Should Be ([System.Boolean])

            $Config.MyBooleanFalse           | Should Be $ResultBooleanFalse
            $Config.MyBooleanFalse.GetType() | Should Be ([System.Boolean])
        }

        It 'shloud be able to parse an array' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config.MyArray           | Should Not BeNullOrEmpty
            $Config.MyArray           | Should Be $ResultArray
            $Config.MyArray.GetType() | Should Be ([System.Object[]])
        }

        It 'shloud be able to parse an hashtable' {

            $Config = ConvertFrom-ScriptConfigXml -Content $Content

            $Config.MyHashtable           | Should Not BeNullOrEmpty
            $Config.MyHashtable.Keys      | Should Be $ResultHashtable.Keys
            $Config.MyHashtable.Values    | Should Be $ResultHashtable.Values
            $Config.MyHashtable.GetType() | Should Be ([System.Collections.Hashtable])
        }
    }
}
