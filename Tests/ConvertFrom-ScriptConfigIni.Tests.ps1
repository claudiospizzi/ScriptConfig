
# Load module
if ($Env:APPVEYOR -eq 'True')
{
    $Global:TestRoot = (Get-Module ScriptConfig -ListAvailable | Select-Object -First 1).ModuleBase

    Import-Module ScriptConfig -Force
}
else
{
    $Global:TestRoot = (Split-Path -Parent $MyInvocation.MyCommand.Path | Join-Path -ChildPath '..' | Resolve-Path).Path

    Import-Module "$Global:TestRoot\ScriptConfig.psd1" -Force
}

# Execute tests
InModuleScope ScriptConfig {

    Describe 'ConvertFrom-ScriptConfigIni' {

        $ResultString          = 'This is a test INI config file!'
        $ResultIntegerPositive = 42
        $ResultIntegerNegative = -153
        $ResultBooleanTrue     = $true
        $ResultBooleanFalse    = $false
        $ResultArray           = @( 'Lorem', 'Ipsum' )
        $ResultHashtable       = @{ Foo = 'Bar'; Hello = 'World' }

        $Content = Get-Content -Path "$Global:TestRoot\Examples\IniConfigDemo.ps1.config"

        It 'should be able to convert the example config file' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config | Should Not BeNullOrEmpty
        }

        It 'shloud be able to parse a string' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config.MyString           | Should Be $ResultString
            $Config.MyString.GetType() | Should Be ([System.String])
        }

        It 'shloud be able to parse an integer' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config.MyIntegerPositive           | Should Be $ResultIntegerPositive
            $Config.MyIntegerPositive.GetType() | Should Be ([System.Int32])

            $Config.MyIntegerNegative           | Should Be $ResultIntegerNegative
            $Config.MyIntegerNegative.GetType() | Should Be ([System.Int32])
        }

        It 'shloud be able to parse an boolean' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config.MyBooleanTrue           | Should Be $ResultBooleanTrue
            $Config.MyBooleanTrue.GetType() | Should Be ([System.Boolean])

            $Config.MyBooleanFalse           | Should Be $ResultBooleanFalse
            $Config.MyBooleanFalse.GetType() | Should Be ([System.Boolean])
        }

        It 'shloud be able to parse an array' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config.MyArray           | Should Not BeNullOrEmpty
            $Config.MyArray           | Should Be $ResultArray
            $Config.MyArray.GetType() | Should Be ([System.Object[]])
        }

        It 'shloud be able to parse an hashtable' {

            $Config = ConvertFrom-ScriptConfigIni -Content $Content

            $Config.MyHashtable           | Should Not BeNullOrEmpty
            $Config.MyHashtable.Keys      | Should Be $ResultHashtable.Keys
            $Config.MyHashtable.Values    | Should Be $ResultHashtable.Values
            $Config.MyHashtable.GetType() | Should Be ([System.Collections.Hashtable])
        }
    }
}
