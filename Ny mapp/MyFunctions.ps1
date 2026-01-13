enum ColorEnum {
    red
    green
    blue
    yellow
}

class Participant {
    [String] $name
    [int] $Age
    [String] $Color
    [int] $UserID

    Participant ([string] $name, [int] $Age, [String] $color, [int] $UserID) {
        $this.name = $name
        $this.Age = $Age
        $this.Color = $Color
        $this.UserID = $UserID
   
    }

    [String] toString() {
        return "{0},{1},{2},{3}" -f $this.name, $this.Age, $this.Color, $this.UserId
    }

}
function GetUserData {
    try {
        $MyUserListFile = "$PSScriptRoot\MyLabFile.csv"
        $MyUserList = Get-Content -Path $MyUserListFile -ErrorAction stop | ConvertFrom-Csv
        $MyUserList
    }
    catch [System.Management.Automation.ItemNotFoundException] {
        Write-Error "Database file does not exist"
    }
    catch {
        throw "Unknown error $_" 
    }
   
    #$MyUserList = Invoke-RestMethod 'http://localhost:666/api'
    #$MyUserList = $MyUserList.result

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
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv",
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

function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        $DatabaseFile = "$PSScriptRoot\MyLabFile.csv"
      
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

function Confirm-CourseID {
    [CmdletBinding()]
    param ()
              
    begin {
        $AllUsers = GetUserData
    }
    
    process {
        foreach ($user in $AllUsers) {
            if ($user.id -notmatch '^\d+$') {
                write-error  "Name: $($user.name), ID: $($user.ID) contains non-numerical characters" 
            }
        }
        
    }
    
    end {
        
    }
}