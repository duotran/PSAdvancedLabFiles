<#
.SYNOPSIS
    'This Function will get a course user'
.DESCRIPTION
    A longer description of the function, its purpose, common use cases, etc.
.NOTES
    Information or caveats about the function e.g. 'This function is not supported in Linux'
.LINK
    Specify a URI to a help page, this will show when Get-Help -Online is used.
.EXAMPLE
    Test-MyTestFunction -Verbose
    Explanation of the function or its result. You can include multiple examples with additional .EXAMPLE lines
#>
function Get-CourseUser {
    [cmdletbinding()]
    param (
        [Parameter()]
        [string]$UserName,   
        [Parameter()]
        [int]$OlderThan = 65
    )

    $output = GetUserData
    if (-not [String]::IsNullOrEmpty($UserName)) {
        <# Action to perform if the condition is true #>
        $output = $output | Where-Object -Property Name -Like "$UserName*"
    }

    if ($OlderThan) {
        <# Action to perform if the condition is true #>
        $output = $output | Where-Object -Property Age -ge $OlderThan
    }
    $output
}