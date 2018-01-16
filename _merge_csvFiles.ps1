# from https://gallery.technet.microsoft.com/scriptcenter/CombineMerge-multiple-CSV-23a53e83#content

function Merge-CSVFiles { 
[cmdletbinding()] 
param( 
    [string[]]$CSVFiles, 
    [string]$OutputFile = "c:\merged.csv" 
) 
$Output = @(); 
foreach($CSV in $CSVFiles) { 
    if(Test-Path $CSV) { 
         
        $FileName = [System.IO.Path]::GetFileName($CSV) 
        $temp = Import-CSV -Path $CSV | select *, @{Expression={$FileName};Label="FileName"} 
        $Output += $temp 
 
    } else { 
        Write-Warning "$CSV : No such file found" 
    } 
} 
$Output | Export-Csv -Path $OutputFile -NoTypeInformation 
Write-Output "$OutputFile successfully created" 
}

# paths
$reportsPath = '\\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\'

$academicsupport = $reportsPath + 'academicsupport.csv'
$adminoff = $reportsPath + 'adminoff.csv'
$allteach = $reportsPath + 'allteach.csv'
$asstprinall = $reportsPath + 'asstprinall.csv'
$charters = $reportsPath + 'charters.csv'
$indian = $reportsPath + 'indianed.csv'
$prinall = $reportsPath + 'prinall.csv'
$prinsecall = $reportsPath + 'prinsecall.csv'
$wilson= $reportsPath + 'wilson.csv'

$SLmemo = $reportsPath + '\upload\SLmemo.csv'
$DistrictDish = $reportsPath + '\upload\DistrictDish.csv'
$TeacherConnect = $reportsPath + '\upload\TeacherConnect.csv'
# end paths

# USAGE:  Merge-CSVFiles -CSVFiles C:\temp\file1.csv,C:\temp\file2.csv -OutputFile c:\temp\output.csv
Merge-CSVFiles -CSVFiles $academicsupport,$indian,$prinall,$prinsecall,$asstprinall,$charters -OutputFile $SLmemo
Merge-CSVFiles -CSVFiles $allteach,$academicsupport,$indian,$prinall,$prinsecall,$asstprinall ,$charters -OutputFile $TeacherConnect
Merge-CSVFiles -CSVFiles $adminoff,$indian,$wilson -OutputFile $DistrictDish
