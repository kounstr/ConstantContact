﻿Remove-Item D:\Scripts\ConstantContact\reports\emailed\*.csv -Recurse
Get-ChildItem -Path D:\Scripts\ConstantContact\reports -include *.csv -Recurse | Move-Item -Destination D:\Scripts\ConstantContact\reports\emailed