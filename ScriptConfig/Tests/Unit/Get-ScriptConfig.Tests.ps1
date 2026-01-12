
$modulePath = Resolve-Path -Path "$PSScriptRoot\..\..\.." | Select-Object -ExpandProperty Path
$moduleName = Resolve-Path -Path "$PSScriptRoot\..\.." | Get-Item | Select-Object -ExpandProperty BaseName

Remove-Module -Name $moduleName -Force -ErrorAction SilentlyContinue
Import-Module -Name "$modulePath\$moduleName" -Force

Describe 'Get-ScriptConfig' {

    Context 'Test Data' {

        It 'shloud be able to load a valid INI configuration file' {

            # Arrange
            $expectedArray     = @( 'Lorem', 'Ipsum' )
            $expectedHashtable = @{ Foo = 'Bar'; Hello = 'World' }

            # Act
            $config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini" -Format 'INI'

            # Assert
            $config                                   | Should -Not -BeNullOrEmpty
            $config.MyString                          | Should -Be 'This is a test INI config file!'
            $config.MyIntegerPositive                 | Should -Be 42
            $config.MyIntegerNegative                 | Should -Be -153
            $config.MyBooleanTrue                     | Should -BeTrue
            $config.MyBooleanFalse                    | Should -BeFalse
            $config.MyArray                           | Should -Be $expectedArray
            $config.MyHashtable.Keys -as [string[]]   | Should -Be ($expectedHashtable.Keys -as [string[]])
            $config.MyHashtable.Values -as [string[]] | Should -Be ($expectedHashtable.Values -as [string[]])
        }

        It 'shloud be able to load a valid JSON configuration file' {

            # Arrange
            $expectedArray     = @( 'Lorem', 'Ipsum' )
            $expectedHashtable = @{ Foo = 'Bar'; Hello = 'World' }

            # Act
            $config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json" -Format 'JSON'

            # Assert
            $config                                   | Should -Not -BeNullOrEmpty
            $config.MyString                          | Should -Be 'This is a test JSON config file!'
            $config.MyIntegerPositive                 | Should -Be 42
            $config.MyIntegerNegative                 | Should -Be -153
            $config.MyBooleanTrue                     | Should -BeTrue
            $config.MyBooleanFalse                    | Should -BeFalse
            $config.MyArray                           | Should -Be $expectedArray
            $config.MyHashtable.Keys -as [string[]]   | Should -Be ($expectedHashtable.Keys -as [string[]])
            $config.MyHashtable.Values -as [string[]] | Should -Be ($expectedHashtable.Values -as [string[]])
        }

        It 'shloud be able to load a valid XML configuration file' {

            # Arrange
            $expectedArray     = @( 'Lorem', 'Ipsum' )
            $expectedHashtable = @{ Foo = 'Bar'; Hello = 'World' }

            # Act
            $config = Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml" -Format 'XML'

            # Assert
            $config                                   | Should -Not -BeNullOrEmpty
            $config.MyString                          | Should -Be 'This is a test XML config file!'
            $config.MyIntegerPositive                 | Should -Be 42
            $config.MyIntegerNegative                 | Should -Be -153
            $config.MyBooleanTrue                     | Should -BeTrue
            $config.MyBooleanFalse                    | Should -BeFalse
            $config.MyArray                           | Should -Be $expectedArray
            $config.MyHashtable.Keys -as [string[]]   | Should -Be ($expectedHashtable.Keys -as [string[]])
            $config.MyHashtable.Values -as [string[]] | Should -Be ($expectedHashtable.Values -as [string[]])
        }
    }

    Context 'Mocked Convert Script' {

        Mock ConvertFrom-ScriptConfigIni  { return @{} } -ModuleName 'ScriptConfig' -Verifiable
        Mock ConvertFrom-ScriptConfigJson { return @{} } -ModuleName 'ScriptConfig' -Verifiable
        Mock ConvertFrom-ScriptConfigXml  { return @{} } -ModuleName 'ScriptConfig' -Verifiable

        It 'should call the INI function if a .ini file is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini" | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigIni' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }

        It 'should call the JSON function if a .json file is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json" | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigJson' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }

        It 'should call the XML function if a .xml file is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml" | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigXml' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }

        It 'should call the INI function if INI format is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.ini" -Format 'INI' | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigIni' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }

        It 'should call the JSON function if JSON format is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.json" -Format 'JSON' | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigJson' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }

        It 'should call the XML function if XML format is specified' {

            # Act
            Get-ScriptConfig -Path "$PSScriptRoot\TestData\config.xml" -Format 'XML' | Out-Null

            # Assert
            Assert-MockCalled 'ConvertFrom-ScriptConfigXml' -ModuleName 'ScriptConfig' -Scope 'It' -Times 1 -Exactly
        }
    }
}
