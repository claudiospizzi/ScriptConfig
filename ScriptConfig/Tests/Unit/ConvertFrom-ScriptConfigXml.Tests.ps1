
BeforeAll {

    $modulePath = Resolve-Path -Path "$PSScriptRoot\..\..\.." | Select-Object -ExpandProperty Path
    $moduleName = Resolve-Path -Path "$PSScriptRoot\..\.." | Get-Item | Select-Object -ExpandProperty BaseName

    Remove-Module -Name $moduleName -Force -ErrorAction SilentlyContinue
    Import-Module -Name "$modulePath\$moduleName" -Force
}

Describe 'ConvertFrom-ScriptConfigXml' {

    It 'should be able to convert the example config file' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config | Should -Not -BeNullOrEmpty
        }
    }

    It 'should be able to parse a string' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config.MyString           | Should -Be 'This is a test XML config file!'
            $config.MyString.GetType() | Should -Be ([System.String])
        }
    }

    It 'should be able to parse an integer' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config.MyIntegerPositive           | Should -Be 42
            $config.MyIntegerPositive.GetType() | Should -Be ([System.Int32])
            $config.MyIntegerNegative           | Should -Be -153
            $config.MyIntegerNegative.GetType() | Should -Be ([System.Int32])
        }
    }

    It 'should be able to parse an boolean' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config.MyBooleanTrue            | Should -BeTrue
            $config.MyBooleanTrue.GetType()  | Should -Be ([System.Boolean])
            $config.MyBooleanFalse           | Should -BeFalse
            $config.MyBooleanFalse.GetType() | Should -Be ([System.Boolean])
        }
    }

    It 'should be able to parse an array' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"
            $expectedArray = @( 'Lorem', 'Ipsum' )

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config.MyArray           | Should -Not -BeNullOrEmpty
            $config.MyArray           | Should -Be $expectedArray
            $config.MyArray.GetType() | Should -Be ([System.Object[]])
        }
    }

    It 'should be able to parse an hashtable' {

        InModuleScope $moduleName {

            # Arrange
            $content = Get-Content -Path "$PSScriptRoot\TestData\config.xml"
            $expectedHashtable = @{ Foo = 'Bar'; Hello = 'World' }

            # Act
            $config = ConvertFrom-ScriptConfigXml -Content $content

            # Assert
            $config.MyHashtable                       | Should -Not -BeNullOrEmpty
            $config.MyHashtable.Keys -as [string[]]   | Should -Be ($expectedHashtable.Keys -as [string[]])
            $config.MyHashtable.Values -as [string[]] | Should -Be ($expectedHashtable.Values -as [string[]])
            $config.MyHashtable.GetType()             | Should -Be ([System.Collections.Hashtable])
        }
    }
}
