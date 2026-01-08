function GetUserData {
   $MyUserListFile = ".\MyLabFile.csv"
    $MyUserList = Get-Content -Path $MyUserListFile | ConvertFrom-Csv
    $MyUserList
}

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

function Add-CourseUser {
    [CmdletBinding()]
    param (
        $DatabaseFile = ".\MyLabFile.csv",
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [Int]$Age,

        [ValidateSet("red", "green", "blue", "yellow")]
        [Parameter(Mandatory)] 
        [String]$color,

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
        $MyCsvUser = "$Name,$Age,{0},{1}" -f $Color, $UserId
        $NewCSv = Get-Content $DatabaseFile -Raw
        $NewCSv += $MyCsvUser

       Set-Content -Value $NewCSv -Path $DatabaseFile
    }


}

function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        $DatabaseFile = ".\MyLabFile.csv"
      
    )
    
    begin {
          $MyUserList = Get-Content -Path $DatabaseFile | ConvertFrom-Csv
          $RemoveUser = $MyUserList | Out-ConsoleGridView -OutputMode Single
    }
    
    process {
        
    }
    
    end {
       
        if ($PSCmdlet.ShouldProcess([string]$RemoveUser.Name)) {
        $MyUserList = $MyUserList | Where-Object {
            -not (
                $_.Name -eq $RemoveUser.Name -and
                $_.Age -eq $RemoveUser.Age -and
                $_.Color -eq $RemoveUser.Color -and
                $_.Id -eq $RemoveUser.Id
            )
        }
        Set-Content -Value $($MyUserList | ConvertTo-Csv -notypeInformation) -Path $MyUserListFile
        
    }
        else {
            Write-Output "Did not remove user $($RemoveUser.Name)"
        }
        }
}