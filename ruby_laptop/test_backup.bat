set SOURCE="C:\Projects\query"
set DESTINATION="C:\Projects\ruby\backup-data\folder B"
set OUTPUT="backp_output.txt"

call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
pause
