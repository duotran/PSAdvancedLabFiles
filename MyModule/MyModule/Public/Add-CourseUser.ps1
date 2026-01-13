<#
.SYNOPSIS
    This function Will add a Course User
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
function Add-CourseUser {
    [CmdletBinding()]
    param (
        $DatabaseFile = "$PSScriptRoot\..\MyLabFile.csv",
        [Parameter(Mandatory)]
        [ValidatePattern({ '^[A-Z][\w\-\s]*$' }, ErrorMessage = 'Name is in an incorrect format')]
        [string]$Name,

        [Parameter(Mandatory)]
        [Int]$Age,

        [Parameter(Mandatory)] 
        [ColorEnum]$color,

        $UserID
    )
    
    begin {
        if ([String]::IsNullOrEmpty($UserId)) {
            $UserID = Get-Random -Minimum 10 -Maximum 100000
        }
    }
    
    process {
        
    }
    
    end {
        $newuser = [Participant]::New($Name, $age, $color, $userid)
        $MyCsvUser = $newuser.ToString()
        $NewCSv = Get-Content $DatabaseFile -Raw
        $NewCSv += $MyCsvUser

        Set-Content -Value $NewCSv -Path $DatabaseFile
    }


}