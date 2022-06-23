@echo off
cls

Rem BASE XAMMP DIR
set xampp=d:\xampp\
echo xampp dir %xampp%

Rem MYSQL.EXE
set mysql=%xampp%mysql\bin\mysql.exe
echo mysql file %mysql%

Rem PID FILE
set pid=%xampp%tomcat\logs\catalina.pid
echo pid file %pid%

Rem TASKLIST FILE
set tasklist=%xampp%tomcat\logs\tasklist.pid
echo tasklist file %tasklist%

Rem FETCH PID of TOMCAT
echo fetching pid id...
setlocal enabledelayedexpansion
set count=0
for /f "tokens=*" %%x in (%pid%) do (
    set /a count+=1
    set var[!count!]=%%x
)
echo pid content %var[1]%
IF [!var[1]!] == [] GOTO :tomcat_stoped

Rem CHECK TOMCAT RUNNING
:check_tomcat_running
@echo catalina_stop...
call %xampp%catalina_stop.bat

@echo wait5...
TIMEOUT 5

echo fetching tasklist...
tasklist /fi "pid eq %var[1]%" > %tasklist%
set count=0
for /f "tokens=*" %%x in (%tasklist%) do (
    set /a count+=1
    set var[!count!]=%%x
)
echo tasklist content 1 %var[1]%
echo tasklist content 2 %var[2]%
echo tasklist content 3 %var[3]%
echo tasklist content 4 %var[4]%
echo tasklist content 5 %var[5]%

echo isEmpty var[3]
IF [!var[3]!] == [] GOTO :tomcat_stoped
GOTO :check_tomcat_running

Rem TOMCAT ALREADY STOPPED
:tomcat_stoped
@echo catalina_stop has stopped

Rem STOP APACHE
call %xampp%apache_stop.bat
@echo apache_stop has stopped

Rem STOP MYSQL
call %xampp%mysql_stop.bat	   
@echo mysql_stop has stopped

Rem CHECK IF MYSQL CLOSED
:check_mysql_closed
echo \q | %mysql% -u root 2>nul
if "%ERRORLEVEL%" == "0" (
	echo mysql still running...
	@echo wait5...
	TIMEOUT 5
	GOTO :check_mysql_closed
) else (
  echo mysql stopped.
)

