set SOURCE="C:\Users\Eylon\Music"
set DESTINATION="H:\Eylon-Laptop\Eylon\Music"
set OUTPUT="Music_backp.txt"

echo "Start pictures backp"
call ruby backup.rb -s %SOURCE% -d %DESTINATION% > %OUTPUT%
echo "Music backp Done"
pause
