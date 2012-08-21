$COPY_COMMAND = "xcopy /D /Y "


def validate_directory_exist(path)
	begin
		fstat = File.stat(path)
		#p (path + " exist")
		if (!fstat.directory?)
			p (sprintf("Error: %s not a directory", path))
			return false
		end
	rescue
		command = "mkdir \"" + path + "\""
		p command
		system(command)
	end
end

def getAllSourceFiles(srcPath)
	#p srcPath
	allDirectoris = []
	allFiles = []
	Dir.chdir(srcPath)
	allElements = Dir["*"]
	#p allElements
	allElements.each do |f|
		fstat = File.stat(f)
		if (fstat.directory?) 
			allDirectoris.push(f)
		else
			allFiles.push(f)
		end
	end
	#p allDirectoris
	#p allFiles
	return allFiles, allDirectoris
end

def copy_file(dstDir, srcDir, fname)
	#p "copy"
	command = $COPY_COMMAND
	srcName = "\"" + srcDir + "\\" + fname + "\""
	dstName = "\"" + dstDir + "\""
	command += srcName + " " + dstName
	#p command
	system(command)
	
end

def copy_path(dstPath, srcPath)
	#p dstPath
	#p srcPath
	
	File.stat(srcPath)
	File.stat(dstPath)
	files, dirs = getAllSourceFiles(srcPath)

	#p files
	files.each do |fname|
		copy_file(dstPath, srcPath, fname)
	end
	
	dirs.each do |dir|
		dstSubDir = dstPath + "\\" + dir
		validate_directory_exist(dstSubDir)
		srcSubDir = srcPath + "\\" + dir
		copy_path(dstSubDir, srcSubDir)
	end
end


#dstPath = "C:\\Projects\\ruby\\backup-data\\folder A"
#dstPath = "C:\\Projects\\ruby\\backup-data\\folder B"
#srcPath = "C:\\Projects\\query"

dstPath = ""
srcPath = ""

len = ARGV.size / 2 - 1
for i in 0..len
	j = i * 2
	key = ARGV[j]
	val = ARGV[j+1]
	
	case key
		when "-d" then dstPath = val
		when "-s" then srcPath = val
	end
end

p ("Source Path: " + srcPath)
p ("Destination Path: " + dstPath)

begin	
	copy_path(dstPath, srcPath)
rescue=>err
	p err
end
#p files
#p dirs

