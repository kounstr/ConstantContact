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
$reportspath = '\\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\'

$academicsupport = $reportspath + 'academicsupport.csv'
$adminoff = $reportspath + 'adminoff.csv'
$allteach = $reportspath + 'allteach.csv'
$asstprinall = $reportspath + 'asstprinall.csv'
$charters = $reportspath + 'charters.csv'
$indian = $reportspath + 'indianed.csv'
$prinall = $reportspath + 'prinall.csv'
$prinsecall = $reportspath + 'prinsecall.csv'
$wilson= $reportspath + 'wilson.csv'

$output = $reportspath + '\upload\test_output.csv'
$SLmemo = $reportspath + '\upload\SLmemo.csv'
$DistrictDish = $reportspath + '\upload\DistrictDish.csv'
$TeacherConnect = $reportspath + '\upload\TeacherConnect.csv'
# end paths

# USAGE:  Merge-CSVFiles -CSVFiles C:\temp\file1.csv,C:\temp\file2.csv -OutputFile c:\temp\output.csv
# TPS USAGE: Merge-CSVFiles -CSVFiles \\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\indianed.csv,\\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\charters.csv -OutputFile \\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\upload\output.csv
# Merge-CSVFiles -CSVFiles $indian,$charters -OutputFile $output


Merge-CSVFiles -CSVFiles $academicsupport,$indian,$prinall,$prinsecall,$asstprinall,$charters -OutputFile $SLmemo
Merge-CSVFiles -CSVFiles $allteach,$academicsupport,$indian,$prinall,$prinsecall,$asstprinall ,$charters -OutputFile $TeacherConnect
Merge-CSVFiles -CSVFiles $adminoff,$indian,$wilson -OutputFile $DistrictDish
