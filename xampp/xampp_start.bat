@echo off
cls

Rem BASE XAMMP DIR
set xampp=d:\xampp\
echo xampp dir %xampp%

Rem MYSQL.EXE
set mysql=%xampp%mysql\bin\mysql.exe
echo mysql file %mysql%

Rem CHECK IF MYSQL IS ACTIVE ALREADY
echo \q | %mysql% -u root 2>nul
if "%ERRORLEVEL%" == "0" (
	echo mysql already running
	GOTO :mysql_already_running
) else (
	echo need to start mysql
)

Rem START MYSQL
@echo mysql_start...
start /b "MYSQL" %xampp%mysql_start.bat

Rem WAIT UNTIL MYSQL STARTED
:check_mysql_running
@echo wait5...
TIMEOUT 5

echo \q | %mysql% -u root 2>nul
if "%ERRORLEVEL%" == "0" (
	echo CONNECTION SUCCESSFUL
) else (
  echo CONNECTION FAILED
  GOTO :check_mysql_running
)

Rem BY NOW MYSQL SHOULD BE STARTED
:mysql_already_running

@echo apache_start...
start /b "APACHE" %xampp%apache_start.bat

@echo catalina_start...
start /b "TOMCAT" %xampp%catalina_start.bat
