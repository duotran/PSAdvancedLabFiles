function Remove-CourseUser {
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    param (
        $DatabaseFile = "$PSScriptRoot\..\MyLabFile.csv"
      
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