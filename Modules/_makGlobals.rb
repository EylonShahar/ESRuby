module MakGlobals 
	$MakRootPath = "C:\\MAK\\vrforcesvrf-cst-2011-07-10"
	#$MakRootPath = "C:\\MAK\\vrforces3.12.0.1v"
	$MakDataPath = $MakRootPath + "\\data"
	$MakOpePath = $MakDataPath + "\\simulationModelSets\\CSIM\\vrfSim"
	$MakOrbatPath = $MakDataPath + "\\orbats"
	$MakScnPath = $MakDataPath + "\\scenarios"
	$MakWeaponsPath = $MakOpePath + "\\systems\\weapons"
	
	$makDirStack = []
	
	def push_mak_dir(dirname)
		curDir = Dir.getwd
		$makDirStack.push(curDir)
		Dir.chdir(dirname)
	end
	
	def pop_mak_dir()
		curDir = $makDirStack.pop
		Dir.chdir(curDir)
	end
	
	def push_mak_ope_dir()
		push_mak_dir($MakOpePath)
	end
	
	def each_ope_file
		allOPes = Dir["*.ope"]	
		allOPes.each do |filename|
			yield filename
		end
	end
end

