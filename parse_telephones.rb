
class MyPerson
	def initialize()
		@name = ""
		@phone = ""
	end

	def print_data()
		printf("%s %d", @name, @phone)
	end

	def set_name(name)
		@name = name
	end

	def set_phone(phone)
		@phone = phone
	end
end

class MyDB
	def initialize()
		@persons = []
	end

	def read_data()
		p = MyPerson.new
		p.set_name("Eylon")
		p.set_phone("1234321");
		@persons = @persons + [p]

	end

	def print_all()
		@persons.each {|x| x.print_data()}
		puts ""
	end
=begin
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
=end

end

class MyParser
end

db = MyDB.new
db.read_data()
db.print_all()


