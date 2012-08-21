require 'cpp_helper_base'

#$ClassName="qryDBIsector"
$ClassName="mag2DLayer"
$ImpClassName = $ClassName + "Imp" 



#bool getHeight(double x, double y, double* z);
class ImpFuncCreator < CppHelper
	def initialize
		super
	end

	def get_rest_of_line(line)
		#p line
		pos = line.index(" ")
		#p pos
		lastPos = line.size-1
		if (line[lastPos] == ";")
			lastPos -= 1
		end
		r = line[pos+1..lastPos]
		#p r
		return r
	end
	
	def set_class_name(name)
		$ClassName = name
		$ImpClassName = $ClassName + "Imp" 
	end
	
	def create(line)
		@lines << line
		add_section_space
		vLines = line.split
		funcType = vLines[0]
		rest = get_rest_of_line(line)
		@lines << String("" << funcType << " " << $ClassName << "::" << rest)
		@lines << "{"
		add_newline
		@lines << "}"
		add_section_space
		@lines << String("" << funcType << " " << $ImpClassName << "::" << rest)
		@lines << "{"
		add_newline
		@lines << "}"
		
		produce_output
	end
end

#if (ARGV.empty?)
#	p "Missing input"
#	exit
#end
#
#obj = ImpFuncCreator.new
#obj.create(ARGV[0])
#obj.produce_output
#




