myArr = ["Eylon", "Yaara", "Nadav"]
puts myArr
myArr2 = myArr - ["Yaara"]
puts myArr2

puts "\n"

for element in myArr
	puts element
end

for element in myArr2
	puts element
end

3.times {print "-"}
puts "\n"


myarr3 = myArr + myArr2
for element in myarr3
	puts element
end


class MtstCls
	def initialize()
		@mmm = "hello"
	end

	def to_s
		puts @mmm
	end

	def set_my_mmm(nnn)
		@mmm = nnn
	end

	def change_str(str)
		str[0] = 'a'
	end
end

5.times {print "-"}
puts "\n"


pip = MtstCls.new
pip2 = pip #MtstCls.new

pip2.set_my_mmm("goog bye")
p pip
p pip2
p pip

mestr = "me me"
p mestr
pip.change_str(mestr)
pip.change_str(mestr)
p mestr









