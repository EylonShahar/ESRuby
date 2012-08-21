set SOURCE="C:\Users\Eylon\Pictures"
set DESTINATION="H:\Eylon-Laptop\Eylon\Pictures"
set OUTPUT="pictures_backp.txt"

echo "Start pictures backp"
call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
echo "Pictures backp Done"
pause
