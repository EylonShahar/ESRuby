class CdbFileData
	def initialize()
		@minLon = 0
		@maxLon = 0
		@minLat = 0
		@maxLat = 0
	end

	def to_s()
		printf("(%f - %f), (%f %f)", @minLon, @maxLon, @minLat, @maxLat)
	end

	def make_from_name(fileName)
		s = String.new(fileName)
		raise "Expecting N or S" if ((s[0] != 'N') and (s[0] != 'S'))

		latSign = (s[0] == 'N') ? 1 : -1
		lat = s[1..2].to_i * latSign

		s[0..2] = ""
		raise "Expecting E or W" if ((s[0] != 'E') and (s[0] != 'W'))

		lonSign = (s[0] == 'E') ? 1 : -1
		lon = s[1..3].to_i * lonSign

		i = s.index('L')
		raise "Expecting L" if (i == nil)
		s[0..i-1] = ""
		if ((s[1] == 'C') or (s[0..2] == "L00"))
			@minLon = lon
			@minLat = lat
			@maxLon = lon + 1
			@maxLat = lat + 1
			return
		end

		lod = s[1..2].to_i
		tileSize = 1.0 / 2**lod
		i = s.index('U')
		raise "Expecting U in name" if (i == nil)
		s[0..i] = ""
		u = s[0].to_i
		r = s[3].to_i


		@minLon = lon + r * tileSize;
		@maxLon = @minLon + tileSize;
		@minLat = lat + u * tileSize;
		@maxLat = @minLat + tileSize;


	end # make_from_name
end # CdbFileData


p ARGV

cfd = CdbFileData.new
#fname = "N33W117_D001_S001_T001_L02_U2_R2.tif"
fname = ARGV[0]
begin
	cfd.make_from_name(fname)
	p cfd
rescue => ex
	p ex
end





