

class MakChecker

	def get_all_scn_files(rootPath)
		scnPath = rootPath + "\\vrforces3.12.0.1v\\data\\scenarios"
		Dir.foreach(scnPath) do |f|
			p f
		end
	end

end


mc = MakChecker.new
mc.get_all_scn_files("c:\\mak")
