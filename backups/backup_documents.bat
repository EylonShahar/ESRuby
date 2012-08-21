set BCKUP_NAME=Documents
set SOURCE="C:\Users\Eylon\%BCKUP_NAME%"
set DESTINATION="H:\Eylon-Laptop\Eylon\%BCKUP_NAME%"
set OUTPUT=%BCKUP_NAME%_backp.txt

echo "Start " %BCKUP_NAME% " backp"
call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
echo %BCKUP_NAME% " backp Done"
