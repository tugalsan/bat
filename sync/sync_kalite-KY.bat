@ECHO OFF
SETLOCAL EnableExtensions DisableDelayedExpansion
@REM Get the current code page and remember it with the environment variable InitialCodePage.
FOR /F "tokens=*" %%I IN ('%SystemRoot%\System32\chcp.com') DO FOR %%J IN (%%I) DO SET /A "InitialCodePage=%%J" 2>NUL
@REM Change the code page to UTF-8.
%SystemRoot%\System32\chcp.com 65001 >NUL

@REM GLOBALS
SET "V_PF=\\10.0.0.222\kalite_dokumanlar\"
SET "V_PT=C:\me\desk\KALİTE\"

@REM INIT
GOTO:F_MAIN

@REM FUNCTIONS
:F_SYNC
    SET "V_IN=%~1"
    @REM /NDL /NFL: NO LOGS = NO GARBAGE CHARS CON:
    @REM /NJH /NJS: NO VERBOSE START-END 
    @REM /R:3: LIMIT RETRY 
    @REM /W:10: WAIT ON ERROR 
    %SystemRoot%\System32\robocopy.exe "%V_PF%%V_IN%" "%V_PT%%V_IN%" /MIR /R:3 /W:10
EXIT /B 0

@REM MAIN
:F_MAIN
CALL :F_SYNC "DESTEK"

@REM Restore the initial code page.
%SystemRoot%\System32\chcp.com %InitialCodePage% >NUL
ENDLOCAL

@REM SAVE THAT CODE ENCODED UTF-8 WITHOUT BOM
pause