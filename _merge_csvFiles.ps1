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


# USAGE:  Merge-CSVFiles -CSVFiles C:\temp\file1.csv,C:\temp\file2.csv -OutputFile c:\temp\output.csv
# TPS USAGE: Merge-CSVFiles -CSVFiles \\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\emailed\indianed.csv,\\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\emailed\charters.csv -OutputFile \\esc-msr-v-ut01\d$\Scripts\ConstantContact\reports\emailed\output.csv


Merge-CSVFiles -CSVFiles reports\academicsupport.csv,reports\indianed.csv,reports\prinall.csv,reports\prinsecall.csv,reports\asstprinall.csv,reports\charters.csv -OutputFile reports\upload\SLmemo.csv
Merge-CSVFiles -CSVFiles reports\allteach.csv,reports\academicsupport.csv,reports\indianed.csv,reports\prinall.csv,reports\prinsecall.csv,reports\asstprinall.csv,reports\charters.csv -OutputFile reports\upload\TeacherConnect.csv
Merge-CSVFiles -CSVFiles reports\adminoff.csv,reports\indianed.csv,reports\wilson.csv -OutputFile reports\upload\DistrictDish.csv
