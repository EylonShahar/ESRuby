
$MonNumToTxt = {
	8 => "Aug"
}

class MyTime
	def initialize(t)
		@m_sYear_2 = t.year.to_s[2..3]
		@m_sText = "" << t.mon.to_s << "/" << t.day.to_s << "/" << @m_sYear_2
		@m_sMonTxt = $MonNumToTxt[t.mon]
		@m_sDay = t.day.to_s
	end
	
	def to_s
		@m_sText
	end
	
	def mon_txt 
		@m_sMonTxt
	end
	
	def day
		@m_sDay
	end
end


fromTime = MyTime.new(Time.now - 60*60*24*7)
toTime = MyTime.new(Time.now - 60*60*24*3)
linesOut = []
s = "Eylon Shahar - Working hours for Elbit during "
s << fromTime.mon_txt << " " << fromTime.day << " - " <<  toTime.mon_txt << " " << toTime.day << "\n"
linesOut << s
linesOut << "\n"
linesOut << "Hi\n"
linesOut << "\n"
linesOut << "During the week of " << fromTime.to_s << " - " << toTime.to_s << " I have worked 45 hours for Elbit\n"
linesOut << "\n"
linesOut << "Thanks\n"
linesOut << "\n"
linesOut << "Eylon\n"
linesOut << "\n"

File.open("eee_3254.txt", "w") do |f|
	linesOut.each {|l| f << l}
end

system("notepad eee_3254.txt");

