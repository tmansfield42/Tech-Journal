. "C:\Users\Michael\Desktop\Classes.ps1"

$table = classes

$mytable = $table | Where-Object { ($_."Class Code" -ilike "SYS*") -or 
                        ($_."Class Code" -ilike "NET*") -or 
                        ($_."Class Code" -ilike "SEC*") -or
                        ($_."Class Code" -ilike "FOR*") -or
                        ($_."Class Code" -ilike "CSI*") -or
                        ($_."Class Code" -ilike "DAT*")
 } #| Select-Object "Instructor" | Sort-Object "Instructor" -Unique


 
 $table | where { ($_.Instructor -in $mytable.Instructor)  -and ($_.Instructor -notlike "*8/25**")} | Group-Object "Instructor" 
 | Sort-Object Count, Name | Sort-Object Count -Descending | Format-Table -Property Count, Name


# Select-Object "Class Code", Instructor, Location, Days, "Time_start", "Time_end"

 