
p "Enter variable: "
line = gets
nline = line.chomp
vline = nline.split
if (vline.size != 2)
	p "should enter type and var-name"
	raise
end

p "Enter comment:"
comment = gets

typeName = vline[0]
strSize = vline[1].size - 1
str = vline[1]
pre = str[0].downcase
localName = pre + str[1..strSize]

#p pre
#p localName
className = "m_" + str
#p className

lines = []

# write variable
lines.push(vline[0] + "\tm_" + vline[1] + ";")
lines.push("")

# write the set function
lines.push ("// Set " + comment)
lines.push(sprintf("void set%s(%s %s)", localName[1..localName.size-1], typeName, localName))
lines.push("{")
lines.push(sprintf("\t%s = %s;", className, localName))	
lines.push("}")
lines.push("");

# write the get function
lines.push ("// Get " + comment)
lines.push(sprintf("%s get%s(void)", typeName, localName[1..localName.size-1]))
lines.push("{")
lines.push(sprintf("\treturn %s;", className))	
lines.push("}")
lines.push("");

File.open("myTemp.txt", "w") do |f|
	lines.each {|x| f.puts x}
end

commad = "notepad myTemp.txt"
system(commad)

#lines.push("void set" + localName[1..localName.size-1] + "(" + typeName + )


#int nNumElements
#void setNumElements(int numElements)
#{
#	m_nNumElements = nNumElements
#}