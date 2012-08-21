class PhoneParser
	def initialize()
	end
	
	def check_ext(ext)
		p ext
		if (ext == "050")
			return true
		else
			return false
		end
	end
	
	def parse_phone(num)
		if (num.length() == 10)
			# p "this is 7"
			if (check_ext(num[0..2]))
				s = num[0..2] + "-" + num[3..9]
				return s
			end
		end
		
		return nil
	end
end

ps = PhoneParser.new
s = ps.parse_phone("0507224115")
p s



