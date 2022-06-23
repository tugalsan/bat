# Based on this answer: https://stackoverflow.com/a/61859561/1956278
$loc = "D:\xampp\mysql"
$dataOld = "./data_old_$(get-date -f yyyy-MM-dd-hh-mm-ss)"
$dataOld_ibdata1 = $( $dataOld + "/ibdata1" )
$backup = "./backup"
$target = "./data"
$target_ibdata1 = $( $target + "/ibdata1" )
$targetTest = "./data/test"

Write-Output $( "Will go to dir " + $loc )
pause
Set-Location -Path $loc

Write-Output $( "Will rename data to " + $dataOld )
pause
Rename-Item -Path $target -NewName $dataOld

Write-Output $( "Will copy data from " + $backup + " to " +  $target )
pause
Copy-Item -Path $backup -Destination $target -Recurse

Write-Output $( "Will delete directory " + $targetTest )
pause
Remove-Item $targetTest -Recurse

Write-Output $( "Will restore databases except mysql,performance_schema,phpmyadmin from " + $dataOld + " to " + $target )
pause
$dbPaths = Get-ChildItem -Path $dataOld -Exclude ('mysql', 'performance_schema', 'phpmyadmin') -Recurse -Directory
Copy-Item -Path $dbPaths.FullName -Destination $target -Recurse

Write-Output $( "Will restore ibdata1 from " + $dataOld_ibdata1 + " to " + $target_ibdata1 )
pause
Copy-Item -Path $dataOld_ibdata1 -Destination $target_ibdata1 
Write-Output $( "Previous data is located at " + $dataOld )

Write-Output $( "Start Mysql Now!" )
pause
Write-Output $( "goto http://localhost/phpmyadmin and press log-out once..." )
$url = "http://localhost/phpmyadmin/index.php?route=/logout"
PowerShell Invoke-WebRequest -Uri $url -Method GET 

pause
