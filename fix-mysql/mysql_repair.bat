@ECHO OFF
echo mysql_repair...

D:\xampp\mysql\bin\mysqlcheck -u root -p --auto-repair --check --all-databases