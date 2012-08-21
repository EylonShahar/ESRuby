module MakUtil

	$MakRootPath = "C:\\MAK\\vrforcesvrf-cst-2011-07-25"
	#$MakRootPath = "C:\\MAK\\vrforces3.12.0.1v"
	$MakDataPath = $MakRootPath + "\\data"
	$MakOpePath = $MakDataPath + "\\simulationModelSets\\CSIM\\vrfSim"
	$MakOrbatPath = $MakDataPath + "\\orbats"
	$MakScnPath = $MakDataPath + "\\scenarios"
	$MakWeaponsPath = $MakOpePath + "\\systems\\weapons"
	
	$makDirStack = []
	
	$MAK_PARAM_TYPES = {}
	
	$MAK_PARAM_TYPES["ground-vehicle-param"] = :GROUND
	$MAK_PARAM_TYPES["aggregate-object-param"] = :AGGREGATE
	$MAK_PARAM_TYPES["vrf-object-param"] = :OBJECT
	$MAK_PARAM_TYPES["human-param"] = :HUMAN
	$MAK_PARAM_TYPES["rotary-wing-entity-param"] = :ROTARY_WING 
	$MAK_PARAM_TYPES["fixed-wing-entity-param"] = :FIXED_WING
	$MAK_PARAM_TYPES["mine-field-param"] = :MINE_FIELD
	$MAK_PARAM_TYPES["missile-param"] = :MISSILE
	$MAK_PARAM_TYPES["cultural-feature-param"] = :CULTURAL_FEATURE 
	$MAK_PARAM_TYPES["surface-entity-param"] = :SURFACE_ENTITY
	$MAK_PARAM_TYPES["subsurface-entity-param"] = :SUBSURFACE_ENTITY
	$MAK_PARAM_TYPES["global-environment-param"] = :GLOBAL_ENVIRONMENT
	$MAK_PARAM_TYPES["prepared-position-param"] = :PREPARED_POSITION
	$MAK_PARAM_TYPES["tactical-smoke-param"] = :TACTICAL_SMOKE
	$MAK_PARAM_TYPES["moving-object-param"] = :MOVING_OBJECT

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
	
	def get_parameter_type(filename)
		File.open(filename) do |f|
			f.each do |line|
				pos = line.index("parameter-type")
				if (pos == nil) then next end				
				endpos = line.index(")")
				if (endpos == nil) then next end
				name = line[pos+16..endpos-2]
				if ($MAK_PARAM_TYPES[name] == nil) then next end
				return $MAK_PARAM_TYPES[name]
			end
		end
		return nil
	end
end


