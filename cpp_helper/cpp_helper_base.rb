class CppHelper
	def initialize
		@lines = []
	end
	
	def add_seperator
		@lines.push("//////////////////////////////////")
	end
	
	def add_newline
		@lines.push("")
	end
	
	def add_section_space
		add_newline
		add_seperator
		add_newline
	end
	
	def produce_output
		File.open("myTemp.cpp", "w") do |f|
			@lines.each {|x| f.puts x}
		end	
		commad = "notepad myTemp.cpp"
		system(commad)
	end
end
