%SystemRoot%\System32\chcp.com 65001 >nul

@ECHO OFF

@REM CHECK IF 65001 applied?
%SystemRoot%\System32\chcp.com

@REM GLOBALS
SET V_PF=\\10.0.0.222\kalite_denetimleri\Yönetim Gözden Geçirme\
SET V_PT=C:\me\desk\KALİTE\YGG\

@REM INIT
GOTO:F_MAIN

@REM FUNCTIONS
:F_SYNC
	SETLOCAL ENABLEDELAYEDEXPANSION
		SET V_IN=%~1
		@REM /NDL /NFL: NO LOGS = NO GARBAGE CHARS CON:
		@REM /NJH /NJS: NO VERBOSE START-END 
		@REM /R:3: LIMIT RETRY 
		@REM /W:10: WAIT IN ERROR 
		%SystemRoot%\System32\robocopy.exe "%V_PF%%V_IN%" "%V_PT%%V_IN%" /MIR /R:3 /W:10
	ENDLOCAL
EXIT /B 0

@REM MAIN
:F_MAIN
call :F_SYNC "2020"
call :F_SYNC "2021"
call :F_SYNC "2022"

@REM SAVE WITH NOTEPAD++ ENCODED UTF8 WITHOUT BOM
pause
