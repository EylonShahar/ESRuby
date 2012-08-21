set SOURCE="C:\Users\Eylon\Documents\Bank of America"
set DESTINATION="H:\Eylon-Laptop\Eylon\Documents\Bank of America"
set OUTPUT="backp_output.txt"

call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
pause
