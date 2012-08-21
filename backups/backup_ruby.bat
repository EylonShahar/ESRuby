set BCKUP_NAME=ruby
set SOURCE="C:\Projects\%BCKUP_NAME%"
set DESTINATION="H:\Eylon-Laptop\Projects\Projects\%BCKUP_NAME%"
set OUTPUT=%BCKUP_NAME%_backp.txt

echo "Start " %BCKUP_NAME% " backp"
call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
echo %BCKUP_NAME% " backp Done"
