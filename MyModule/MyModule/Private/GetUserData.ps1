function GetUserData {
    try {
        $MyUserListFile = "$PSScriptRoot\..\MyLabFile.csv"
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