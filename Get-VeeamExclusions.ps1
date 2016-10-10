Add-PSSnapin VeeamPSSnapin

$JobList = Get-VBRJob
$ExclusionList = @()
foreach($Job in $JobList)
{
    #Get exclusion per job
    $exclusions = $job.GetObjectsInJob() | Where-Object {$_.Type -eq "Exclude"}
    $VMExclusions = @()
    foreach ($exclusion in $exclusions)
    {
        $VMExclusions += ($exclusion.name)
    }
    
    $ExclusionList += New-Object -typeName psobject -Property @{
        Name = $job.Name
        ExcludedVMs = "$VMExclusions"
    }

    #$ExclusionList += $job.GetObjectsInJob() | Where-Object {$_.Type -eq "Exclude"}
}

$ExclusionList | Export-Csv ExcludedVMs.csv -delimiter ";" -NoTypeInformation