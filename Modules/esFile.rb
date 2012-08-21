
class EsFile
	attr_accessor :allLines, :filename
	def initialize
		@allLines = []
		@filename = ""
	end
	
	def read_file(filename)
		@filename = filename
		File.open(filename) do |f|
			f.each do |line|
				@allLines.push(line)
			end
		end
	end
	
	def write_file(filename=nil)
		fname = ""
		if (filename != nil)
			fname = filename
		else
			fname = @filename
		end
		
		p "Save file " + fname
		File.open(fname, "w") do |f|
			@allLines.each do |line|
				f.puts(line)
			end
		end
	end
	
	def search(str)
		@allLines.each_with_index do |line, lineId|
			pos = line.index(str)
			if (pos == nil) then next end
			yield lineId, pos
		end
	end
	
	def replace(oldStr, newStr)
		matches = 0
		search(oldStr) do |lineId, pos|
			line = @allLines[lineId]
			s0 = ""
			if (pos > 0)
				s0 =  line[0..pos-1]
			end
			oldLen = oldStr.size
			s2 = line[pos+oldLen..line.size-1]
			newLine = s0 + newStr + s2
			@allLines[lineId] = newLine
			matches += 1
		end
		return matches
	end
	
	def add_line(line)
		@allLines.push(line)
	end
end


#esf = EsFile.new
#esf.read_file("rep_test.txt")
#esf.search("banana") do |lineId, pos|
#	p sprintf("search found at %d %d", lineId, pos)
#end
#	esf.replace("banana", "tapuz")
#	esf.write_file
#