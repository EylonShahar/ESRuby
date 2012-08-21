module EsUtils

	def basename(fullname)
		len = fullname.size - 1
		i = len
		while (i > 0)
			if fullname[i] == "\\"
				return fullname[i+1..len]
			end
			i -= 1
		end
		
		return nil
	end

	# uses for transfering strings as argument to functions
	class StringContainer
		attr_accessor :myString
		def initialize
			@myString = ""
		end
	end
	
	def get_my_env(envName)
		s = ENV[envName]
		if s == nil
			raise envName
		end
	
		return s
	end

	def is_file_exist(filename)
		begin 
			fstat = File.stat filename
			return true
		rescue
			return false
		end
	end
end


class EsDirStack
	def initialize
		@myDirStack = []
	end
	
	def push_dir(dirname)
		curDir = Dir.getwd
		@myDirStack.push(curDir)
		Dir.chdir(dirname)
	end
	
	def pop_dir()
		curDir = @myDirStack.pop
		Dir.chdir(curDir)
	end
end #EsDirStack




