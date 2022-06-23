if not "%1"=="am_admin" (powershell start -verb runas '%0' am_admin & exit /b)

robocopy C:\me\codes\ram D:\ /MIR
ATTRIB C:\me\codes\ram -S -h

START D:\xampp\xampp-control.exe
START start microsoft-edge:https://localhost:8443/ASW/App.jsp
START /B /MIN "netbeans" "C:\Program Files\NetBeans-12.4\netbeans\bin\netbeans64.exe" --console suppress


