require 'cpp_helper_base'

class ClassCreator < CppHelper
	
	def initialize
		super
	end
	
	def create(line)
		if (line.empty?)
			alert("Should enter class name!")
			return
		end
		nline = line.chomp
		vline = nline.split
		if (vline.size != 1)
			alert("should enter only class name")
			return
		end

		className = vline[0]
		add_seperator
		@lines.push(sprintf("// Class %s", className))
		@lines.push(sprintf("// Author: Eylon Shahar"))
		@lines.push(sprintf("// Created: %s/%s/%s", Time.now.day, Time.now.mon, Time.now.year))
		@lines.push(sprintf("// Modified: "))
		add_seperator
		add_newline
		@lines.push("class " + className)
		@lines.push("{")
		@lines.push("public:")
		@lines.push("\t//Constructor");
		@lines.push("\t" + className + "(void);")
		@lines.push("\t//Destructor");
		@lines.push("\t~" + className + "(void);")
		@lines.push("")
		@lines.push("private:")
		@lines.push("};")
		@lines.push("")
		@lines.push("")
		
		@lines.push("//Constructor");
		@lines.push(sprintf("%s::%s(void)", className, className))
		@lines.push("{")
		@lines.push("")
		@lines.push("}")
		@lines.push("")
		@lines.push("//Destructor");
		@lines.push(sprintf("%s::~%s(void)", className, className))
		@lines.push("{")
		@lines.push("")
		@lines.push("}")
		@lines.push("")
	
		produce_output
	end
	
end
