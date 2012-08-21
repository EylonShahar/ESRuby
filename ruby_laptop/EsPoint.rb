class EsPoint2D
	attr_reader :x, :y
	def initialize(x, y)
		@x, @y = x, y
	end
	
	def to_s
		printf("(%f, %f)", x, y)
	end
end


mp = EsPoint2D.new(35.5, 47.8)
p mp
p mp.x
p mp.y


