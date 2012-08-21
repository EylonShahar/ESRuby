require 'cpp_helper_base'


class SingletonCreator < CppHelper
	
	def initialize
		super
	end
	
	def create(line)
		if (line.empty?)
			alert("Should enter singleton name!")
			return
		end
		nline = line.chomp
		vline = nline.split
		if (vline.size != 1)
			alert("should enter only singleton name")
			return
		end

		singletonName = vline[0]
		
		@lines.push(sprintf("#include<memory>"))
		add_section_space
		@lines.push(sprintf("public:"))
		@lines.push(sprintf("	// Get singleton instance"))
		@lines.push(sprintf("	static %s* instance();", singletonName))
		add_newline
		@lines.push(sprintf("	// Delete the singleton"))
		@lines.push(sprintf("	static void shutdown();"))
		add_newline
		@lines.push(sprintf("	// Replace the singleton"))
		@lines.push(sprintf("	static void setInstance(%s* pNewInstance);", singletonName))
		add_newline
	
		@lines.push(sprintf("private:"))
		@lines.push(sprintf("	// Singleton instance"))
		@lines.push(sprintf("	static std::auto_ptr<%s> s_pInstance;", singletonName))
		
		add_section_space
		@lines.push(sprintf("std::auto_ptr<%s> %s::s_pInstance;", singletonName, singletonName))
		add_section_space

		@lines.push(sprintf("inline %s* %s::instance()", singletonName, singletonName))
		@lines.push(sprintf("{"))
		@lines.push(sprintf("	if (s_pInstance.get() == NULL)"))
		@lines.push(sprintf("		s_pInstance.reset(new %s);", singletonName))
		@lines.push(sprintf("	return s_pInstance.get();"))
		@lines.push(sprintf("}"))
		
		add_newline
		
		@lines.push(sprintf("inline void %s::shutdown()", singletonName))
		@lines.push(sprintf("{"))
		@lines.push(sprintf("	s_pInstance.reset(NULL);"))
		@lines.push(sprintf("}"))
		add_newline

		@lines.push(sprintf("inline void %s::setInstance(%s* pNewInstance)", singletonName, singletonName))
		@lines.push(sprintf("{"))
		@lines.push(sprintf("	s_pInstance.reset(pNewInstance);"))
		@lines.push(sprintf("}"))

		add_section_space
		#@lines.push(sprintf("%s::~%s()", singletonName, singletonName))
		#@lines.push(sprintf("{"))
		#@lines.push(sprintf("	s_pInstance.release()"))
		#@lines.push(sprintf("}"))
	

		add_section_space
		
		produce_output
	end
	
end

cc = SingletonCreator.new
cc.create("CCqtLogger");

