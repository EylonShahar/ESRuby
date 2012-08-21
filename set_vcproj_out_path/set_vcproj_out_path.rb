require 'xmlsimple'

$outputLines = []

def find_version(filename)
	vcproj = XmlSimple.xml_in(filename)
	if (vcproj == nil)
		return nil
	end

	vspVersion = vcproj["Version"]
	if (vspVersion == nil)
		return nil
	end
		
	return vspVersion.to_i
end

def find_next_slash(line, idx)
	for i in idx..line.size-1
		if (line[i] == "\\" || line[i] == "/")
			return i
		end
	end
	return -1
end

class StrCont
	attr_accessor :myStr
	def initialize
		@myStr = ""
	end
end

def check_output_bin_line(line, version, fixedLine)
	nline = line.upcase
	idx0 = nline.index("BIN")
	if (idx0 == nil)
		return :OK
	end
	
	cor = sprintf("Bin_vc%d", version)
	ncor = cor.upcase
	idx1 = nline.index(ncor)
	if (idx1 != nil)
		return :OK
	end
	
	slashPos = find_next_slash(line, idx0)
	
	if (slashPos < 0)
		return :OK
	end
	
	s0 = line[0..idx0-1]
	s1 = cor
	idx3 = line.size-1
	s2 = line[slashPos..idx3]
	fixedLine.myStr = s0 + s1 + s2
	
	return :NOT_OK
	
end

def check_output_lib_line(line, version, fixedLine)
	nline = line.upcase
	idx0 = nline.index("EXPORTLIB")
	if (idx0 == nil)
		return :OK
	end
	
	cor = sprintf("ExportLib_vc%d", version)
	ncor = cor.upcase
	idx1 = nline.index(ncor)
	if (idx1 != nil)
		return :OK
	end
	
	slashPos = find_next_slash(line, idx0)
	
	if (slashPos < 0)
		return :OK
	end
	
	s0 = line[0..idx0-1]
	s1 = cor
	idx3 = line.size-1
	
	s2 = line[slashPos..idx3]
	fixedLine.myStr = s0 + s1 + s2
	
	return :NOT_OK
	
end



def get_back_name(filename, version)
	idx = filename.rindex(".")
	s0 = filename[0..idx]
	s1 = sprintf("vc%d.vcproj.old", version) #"old.vcproj"
	return (s0 + s1)
end

def backup_vcproj(filename, version)
	backName = get_back_name(filename, version)
	cmd = "move " + filename + " " + backName
	system(cmd)
end

def fix_vcproj(filename)
	outputVctproj = []
	version = find_version(filename)
	if (version < 8) then return end
	makeFixedVersion = false
	
	#p sprintf("Checking %s - version %d", filename, version)
	s = sprintf("\n[%s]", filename)
	$outputLines.push(s)
	$outputLines.push(sprintf("Version = %d", version))
	$outputLines.push(sprintf("Path = %s", Dir.getwd))
	
	fixedLine = ""
	File.open(filename) do |f|
		f.each do |line|

			idx = line.index("OutputDirectory")
			if (idx != nil) 
				$outputLines.push(sprintf("OutputDirectory = %s", line))
				fixedLine = StrCont.new
				ret = check_output_bin_line(line, version, fixedLine)
				if (ret == :OK)
					outputVctproj.push(line)
				else
					makeFixedVersion = true
					outputVctproj.push(fixedLine.myStr)
				end
				next
			end #OutputDirectory

			idx = line.index("ImportLibrary")
			if (idx != nil) 
				$outputLines.push(sprintf("ImportLibrary = %s", line))
				fixedLine = StrCont.new
				ret = check_output_lib_line(line, version, fixedLine)
				if (ret == :OK)
					outputVctproj.push(line)
				else
					makeFixedVersion = true
					outputVctproj.push(fixedLine.myStr)
				end
			else
				outputVctproj.push(line)
			end #ImportLibrary
						
		end
	end
	
	if (!makeFixedVersion)
		return
	end
	
	p sprintf("Fixing %s", filename)
	backup_vcproj(filename, version)
	File.open(filename, "w") do |f|
		outputVctproj.each do |line|
			f.puts(line)
		end
	end
end

def search_vcproj(path)
	curDir = Dir.getwd
	Dir.chdir(path)
	files = Dir["*.vcproj"]
	files.each do |filename|
		fix_vcproj(filename)
	end
	
	files = Dir["*"]
	files.each do |filename|
		s = File.stat(filename)
		if (s.directory?) 
			search_vcproj(filename)
		end
	end
	
	Dir.chdir(curDir)
end



def print_output
	File.open("out.ini", "w") do |f|
		$outputLines.each do |line|
		f.puts(line)
		end
		
	end
end


if (ARGV.size == 0)
	p "Usage: set_vcproj_out_path destination_path"
else
	dstpath = ARGV[0]
	p dstpath
	search_vcproj(dstpath)
	#print_output
	#fix_vcproj("fsops.vcproj")
end





