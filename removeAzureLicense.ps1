function removeAzureLicense {
    [cmdletbinding()]
    param ([string[]]$Users, [string]$skuid)

    foreach ($User In $Users) {

        try {
        
            $Userobj = Get-AzureADUser -SearchString $user

            if ($userobj) {

                # Create the objects we'll need to add and remove licenses
                $license = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicense
                $licenses = New-Object -TypeName Microsoft.Open.AzureAD.Model.AssignedLicenses

                # Find the SkuID of the license we want to add - in this example we'll use the O365_BUSINESS_PREMIUM license
                $license.SkuId = $skuid

                $Licenses.RemoveLicenses = $skuid
            
                Set-AzureADUserLicense -ObjectId $userobj.objectid -AssignedLicenses $licenses
                Write-Verbose ("Removing SKU " + $skuid + " from account " + $user)

            }
        }
        catch {
            Write-Debug ("User " + $user + " not found")
        }
    }
}