function listAzureLicense ($skuid) {
    $LicensedUsers = New-Object System.Collections.Generic.List[System.Object]

    # Retrieve all users from AzureAD
    $users = Get-AzureADUser -All:$true

    foreach ($user in $users) {
        if ($user.AssignedLicenses) {
            foreach ($assignedlicense in $user.AssignedLicenses) {
                if ($assignedlicense.SkuID -eq $skuid) { 
                    $LicensedUsers.Add($user)
                }
            }
        }
    }

    Write-Output $LicensedUsers
}
