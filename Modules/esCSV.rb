# Load CSV files
module EsCSV
	class CSVtableEntry
		def initialize
			@myData = []
		end
		
		def create(line)
			nLine = line.chomp
			@myData = nLine.split(",")
		end
		
		def get_value_by_col_id(column)
			return @myData[column]
		end
		
		def key_name
			return @myData[0]
		end
		
		def add_value(value)
			@myData.push(value)
		end
		
		def to_s
			str = key_name
			for i in 1..@myData.size-1
				str += ","
				str += @myData[i]
			end
			return str
		end
	end
	
	
	class CSVtable
		attr_reader :myEntries, :myEntriesHash
		def initialize
			@myEntries = []
			@myEntriesHash = {}
		end
	
		def load(filename)
			File.open(filename) do |f|
				f.each do |line|
					entry = CSVtableEntry.new
					entry.create(line)
					@myEntries.push(entry)
					keyName = entry.key_name
					@myEntriesHash[keyName] = entry
				end
			end
		end # load
		
		def get_entry_by_key(key)
			return @myEntriesHash[key]
		end # get_entry_by_key
		
		def each_entry
			header = true
			@myEntries.each do |e|
				if header
					header = false
					next
				end
				yield e
			end
		end
		
		def save(filename)
			File.open(filename, "w") do |f|
				@myEntries.each do |entry|
					f.puts(entry)
				end
			end
		end
		
	end # CSVtable
end


#filename = "etities-map.csv"
#table = CSVtable.new
#table.load(filename)
#table.myEntries.each do |entry|
#	s = sprintf("%s,%s", entry.get_value_by_col_id(1), entry.get_value_by_col_id(3))
#	print(s)
#end
#for i in 155..179
#	entry = table.myEntries[i]
#	v = entry.get_value_by_col_id(0)
#	nv = ""
#	for j in 0..v.size-1
#		if (v[j] == " " || v[j] == "(" || v[j] == ")")
#			nv += "-"
#		else
#			nv += v[j]
#		end
#	end
#	
#	#s = sprintf ("\"%s\"\,", nv)
#	s = sprintf("\"%s\"\,\n", nv)
#	print s
#end


