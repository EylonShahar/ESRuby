class Eylon
	def initialize()
		puts "make Eylon"
		@year = 1970
		@names = ["Shahar"]
	end

	def print_year()
		puts @year
	end

	def to_s
		puts "Eylon was born in "  + @year.to_s()
		for element in @names
			puts element
		end
		puts "\n"
	end

	def open_my_file(fname)
		if not File.exist?(fname)
			printf('File %s not exist', fname.to_s)
			puts "\n"
			return false
		end
		File.open(fname, "r") do |infile|
			while (line = infile.gets)
			#	printf("%s", line)
				@names += [line]
			end
		end	
	end
end

e = Eylon.new
e.print_year()
5.times { printf "-" }
puts "\n"
puts e.to_s
puts "\n"
e.open_my_file("eylon.txt")
puts e.to_s



