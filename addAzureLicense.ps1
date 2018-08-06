function addAzureLicense {
    [CmdletBinding()]
    param ([string[]]$Users, [string]$skuid)

    # The function accepts multiple users, parse through them
    foreach ($user in $users) {
    
        $userobj = Get-AzureADUser -SearchString $user

        if ($userobj) {
    
            $license = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
            $licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses

            $license.SkuId = $skuid

            $licenses.AddLicenses = $license

            Write-Verbose ("Adding license with SKU " + $skuid + " to user " + $User)
            Set-AzureADUserLicense -ObjectId $userobj.ObjectID -AssignedLicenses $licenses
        }
        else {
            Write-Error ("User " + $user + " not found.")
        }
    }
}