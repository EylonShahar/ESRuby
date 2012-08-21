
require 'cpp_helper_base'


class VarsCreator < CppHelper
	
	def initialize
		super
	end

	def create (line, comment)
		nline = line.chomp
		vline = nline.split
		if (vline.size != 2)
			alert "should enter type and var-name"
			raise
		end
				
		typeName = vline[0]
		strSize = vline[1].size - 1
		str = vline[1]
		pre = str[0].downcase
		localName = pre + str[1..strSize]
		
		className = "m_" + str
		
		# write variable
		@lines.push("private:")
		@lines.push("\t" + vline[0] + "\tm_" + vline[1] + ";")
		@lines.push("")
		
		if comment == nil then comment = "" end
		# write the set function
		@lines.push ("// Set " + comment)
		@lines.push(sprintf("void set%s(%s %s) {", localName[1..localName.size-1], typeName, localName))
		@lines.push(sprintf("\t%s = %s;", className, localName))	
		@lines.push("}")
		@lines.push("");
		
		# write the get function
		@lines.push ("// Get " + comment)
		@lines.push(sprintf("%s get%s(void) {", typeName, localName[1..localName.size-1]))
		@lines.push(sprintf("\treturn %s;", className))	
		@lines.push("}")
		@lines.push("");
		
		produce_output
		
	end
end
	


