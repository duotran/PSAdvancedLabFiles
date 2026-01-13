Remove-Module -Name 'MyModule' -ErrorAction SilentlyContinue
Import-Module $PSScriptRoot\..\MyModule\

Describe 'Add-CourseUser' {
    BeforeAll{
        Mock -CommandName 'Set-Content' -ModuleName MyModule -MockWith {
            Return 'Works'
        }
    }
    Context 'Testing names' {
        $Testnames = @(
            'Jason Derülo'
            'Björn Skifs'
            'Will.i.am'
            'Sinéad O´Connor'
        )

        It 'Verifying name <_>' -TestCases $Testnames {
              Add-CourseUser -Age 42 -Color red -UserID 666 -Name $_ | Should -be 'works!'
            }
    }
}