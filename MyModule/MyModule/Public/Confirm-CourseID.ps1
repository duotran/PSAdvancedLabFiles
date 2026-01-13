
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