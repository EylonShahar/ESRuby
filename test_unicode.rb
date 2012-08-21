
def aaa
	str = "hello"
	#str2 = "תאריך"
	str2 = "xxx"
	str2[0] = \u150
	p str2
	str2.each_byte do |c|
		p c
	end
end


aaa

