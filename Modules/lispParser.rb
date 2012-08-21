$SPACE_CHAR = [" ", "\t", "\n"]

#$debugFile = File.new("debug.txt", "w")

class LispToken
	attr_accessor :m_nPos, :m_nType, :m_pValue
	def initialize
		@m_nPos = nil
		@m_nType = nil
		@m_pValue = nil
	end
	
	def to_s
		sprintf("Token pos=%d, type=%s value=%s", @m_nPos, @m_nType.to_s, @m_pValue)
	end
end

class LispBlockNode
	attr_accessor  :m_sName, :m_pToken, :m_vSons, :m_nStartPos, :m_nEndPos, :m_nId
	@@nodesCount = 0
	def initialize
		@m_sName = ""
		@m_pToken = nil
		@m_vSons = []
		@m_nStartPos = 0
		@m_nEndPos = 0
		@m_nId = @@nodesCount
		@@nodesCount += 1
	end
	
	def get_value(num=1)
		if (m_pToken == nil) 
			#return nil
			child = get_child(1)
			if (child == nil) then return nil end
			if (child.m_pToken == nil) then return nil end
			return (child.m_pToken.m_pValue)
		end
		return m_pToken.m_pValue
	end
	
	def is_leaf?
		return m_vSons.empty?
	end
	
	def to_s
		str = m_sName + ": "
		if (is_leaf?) 
			str += "Leaf, " + get_value
		else
			str += "Node"
		end  
		
		return str
	end
	
	def each_value
		first = true
		m_vSons.each do |son|
			if first
				first = false
				next
			end
			value = son.get_value
			if (value != nil) then yield value end 
		end
	end
	
	def add_son(son)
		m_vSons.push(son)
		return (m_vSons.size-1)
	end
	
	def print_val(level=0)
		#if (is_leaf?) then return end
		s = ""
		level.times {|i| s += "..."}
		p (s + "Name: " + @m_sName)
		each_value do |val|
			p (s + "Value: " + val)
		end
		
		#if (get_value != nil)
		#	p (s + "Value: " + get_value)
		#end
		#if (@m_pToken != nil)
		#	p (s + @m_pToken.to_s)
		#end
		for i in 1..@m_vSons.size-1
			son = m_vSons[i]
			son.print_val(level+1)
		end
		#@m_vSons.each {|son| son.print_val(level+1)}
	end
	
	def get_name
		return m_sName
	end
	
	def get_num_childrens
		return m_vSons.size
	end
	
	def get_child(num=0)
		return m_vSons[num]
	end
	
	def each_child 
		for i in 1..@m_vSons.size-1
			if (m_vSons[i] == nil) then next end
			yield m_vSons[i]
		end	
	end
	
	def find_nodes_by_name_inter(name, nodes)
		if (@m_sName == name)
			nodes.push(self)
		end
		each_child do |child|
			child.find_nodes_by_name_inter(name, nodes)
		end
	end
	
	def find_nodes_by_name(name)
		nodes = []
		find_nodes_by_name_inter(name, nodes)
		nodes.each {|node| yield node} 
	end
	
	def find_node_by_path_inter(namedPath, nameToNodeHash, idx)
		nodes = []
		find_nodes_by_name_inter(namedPath[idx], nodes)
		if (nodes.empty?) then return nil end
		
		if (idx == namedPath.size-1)
			nameToNodeHash[nodes[0].m_sName] = nodes[0]
			return nodes[0]
		end
		
		nodes.each do |n|
			#p n.m_sName
			nameToNodeHash[n.m_sName] = n
			nextNode = n.find_node_by_path_inter(namedPath, nameToNodeHash, idx+1)
			if (nextNode == nil)
				next
			end
			return n
		end
		return nil
	end	
	
	def find_node_by_path(*namedPath)
		nameToNodeHash = {}
		path = []
		firstNode = find_node_by_path_inter(namedPath, nameToNodeHash, 0);
		if (firstNode)
			return nameToNodeHash
		else
			return nil
		end
	end
end

class LineData
	attr_reader  :m_sLine, :m_nFrom, :m_nTo
	def initialize(line, from, to)
		@m_sLine = line
		@m_nFrom = from
		@m_nTo = to
	end
	
	def to_s
		@m_sLine
	end
end

class LispParser
	def initialize
		@m_pBuffer = nil
		@m_vLines = []
		@m_pRootNode = nil
	end

	def get_lines_in_range(from, to)
		for i in from..to 
			yield @m_vLines[i].m_sLine
		end
	end
	
	def get_line_without_comment(line)
		#p line
		pos = line.index(";")
		if (pos == nil) then return line end
		newLine = line.dup
		for i in pos..newLine.size-1
			newLine[i] = " "
		end	
		#p (line + " => " + newLine)
		return newLine
	end
	
	def load_buffer(filename)
		@m_pBuffer = ""
		offset = 0
		File.open(filename) do |f|
			f.each do |line|
				newLine = get_line_without_comment(line)
				@m_pBuffer += newLine
				@m_vLines.push(LineData.new(line, offset, line.size+offset)) 
				offset += line.size
			end
		end
	end

	def find_line_by_pos(pos)
		@m_vLines.each_with_index do |line, idx|
			if ((pos >= line.m_nFrom) && (pos < line.m_nTo))
				return line, idx+1
			end
		end
	end
	
	def is_space?(pos)
		return ($SPACE_CHAR.include?(@m_pBuffer[pos]))
	end
	
	def buffer_end
		return @m_pBuffer.size
	end
	
	def buffer_from(pos)
		return @m_pBuffer[pos..buffer_end-1]
	end
	
	def advance_blanks(pos)
		while (pos < @m_pBuffer.size)
			if (is_space?(pos))
				pos += 1
				next
			end
			return pos
		end
		return nil
	end
	
	def read_value(pos, buffer=nil)
		if (buffer != nil) then @m_pBuffer = buffer end
		for i in pos..buffer_end-1
			if (is_space?(i)) then break end
			if ((@m_pBuffer[i] == ")") || (@m_pBuffer == "(")) then break end
		end
		if (i == buffer_end-1) then return @m_pBuffer[pos..i-1], i end 
		return @m_pBuffer[pos..i-1], i
	end
	
	def read_text(pos, buffer=nil)
		if (buffer != nil) then @m_pBuffer = buffer end
		if (@m_pBuffer[pos] != "\"") then return nil, pos end
		for i in (pos+1)..(buffer_end-1)
			if (@m_pBuffer[i] == "\"") then break end
		end
		if (i == pos+1) then return "", i+1 end
		return @m_pBuffer[pos+1..i-1], i+1
	end
	
	def read_next_token(pos)
		#$debugFile.puts("enter read_next_token pos = " + pos.to_s + " / " + buffer_end.to_s)
		
		if (pos > buffer_end) then return nil,0 end
		pos = advance_blanks(pos)
		if (pos == nil) then return nil,0 end
		if (pos >  buffer_end) then return nil,0 end
		
		#$debugFile.puts("Buffer:")		
		#$debugFile.puts(buffer_from(pos))		
		
		token = LispToken.new
		#pos = advance_blanks(pos)
		token.m_nPos = pos
		
		case @m_pBuffer[pos]
			when "("
				token.m_nType = :TOKEN_OPEN_BRACKET
				return token, pos+1

			when ")"
				token.m_nType = :TOKEN_CLOSE_BRACKET
				return token, pos+1

			when "\""
				token.m_nType = :TOKEN_TEXT
				text, pos = read_text(pos)
				token.m_pValue = text
				return token, pos
			else
				token.m_nType = :TOKEN_VALUE
				value, pos = read_value(pos)
				token.m_pValue = value
				return token, pos
		end #case
	end
		
	def read_string(pos)
		pos = advance_blanks(pos)
		#p "eee 50"
		#p pos
		start = pos
		for i in pos..@m_pBuffer.size-1
			#p @m_pBuffer[start..i-1]
			if (is_space?(i) or @m_pBuffer[i] == ")")
				#p "eee return"
				return @m_pBuffer[start..i-1], i
			end
		end
		
		raise "Unexpected end of file"
	end
	
	def print_pos(msg, pos)
		p (msg + ": " + @m_pBuffer[pos..@m_pBuffer.size-1])
	end
	
	def build_hierarchy
		pos = 0
		blocksStack = []
		rootNode = nil
		
		while (pos < buffer_end)
			token, pos = read_next_token(pos)
			if (token == nil) then break end
			#$debugFile.puts(buffer_from(pos))
			#$debugFile.puts(pos.to_s + ": " + token.to_s)
			#$debugFile.puts("")
			
			
			case token.m_nType
				when :TOKEN_OPEN_BRACKET
					block = LispBlockNode.new
					block.m_nStartPos = pos
					if (blocksStack.empty?) 
						rootNode = block
						#rootNode.m_sName = "root: " + block.m_nId.to_s
					else
						father = blocksStack.last
						father.add_son(block)
					end
					blocksStack.push(block)
					
				when :TOKEN_CLOSE_BRACKET
					block = blocksStack.pop
					if (block == nil) then raise "unexpeted )" end
					block.m_nEndPos = pos
					
				when :TOKEN_TEXT, :TOKEN_VALUE
					block = blocksStack.last
					if (block == nil)
						lineId = find_line_by_pos(token.m_nPos)
						#p (@m_pBuffer[0..token.m_nPos])
						raise ("Error: Stack Empty line " + lineId.to_s) 
						
					end
					newBlock = LispBlockNode.new
					sonId = block.add_son(newBlock)
					#newBlock.m_sName = sprintf("id %d son %d of %s", newBlock.m_nId, sonId, block.m_sName)
					newBlock.m_nStartPos = token.m_nPos
					newBlock.m_nEndPos = pos
					newBlock.m_pToken = token
			end #end case
		end #end while
		if (blocksStack.size > 0) then raise "To many (" end
		@m_pRootNode = rootNode
		return rootNode
	end #end build_hierarchy
	
	def post_build(rootNode)
		if (rootNode == nil) then return end
		if (rootNode.m_vSons.empty?) then return end
		rootNode.m_sName = rootNode.m_vSons[0].get_value
		#p (sprintf("traverse %s", rootNode.m_sName))
		#rootNode.m_vSons.each_with_index do |son, id|
		#	p (sprintf("...%d - %s", id, son.m_sName))
		#end
		for i in 1..rootNode.m_vSons.size-1
			son = rootNode.m_vSons[i]
			post_build(son)
		end
	end
	
	def parse(filename)
		begin
			load_buffer(filename)
			root = build_hierarchy
			post_build(root)
		rescue=>errMsg
			p errMsg
			root = nil
		end
		
		return root
		#return load_block(0)
	end
end


#lispParser = LispParser.new
#tree = lispParser.parse("Leopard-2A6-Recovery-Tank_1_1_1_78_1_3_2_0.ope")
#tree = lispParser.parse("Leo-Test.oob")
#p "RRRRRRRRRRRRRRRRRRRRRR"
#tree.print_val(0)

#$debugFile.close

#val, pos = lispParser.read_text(0, "\"aba ba\"")
#val, pos = lispParser.read_text(0, "\"\"")
#val, pos = lispParser.read_value(0, "aba ba")
#p val
#p pos
