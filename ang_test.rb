
class AngCalc
	def normalize_angle(ang)
		while (ang < 0.0) 
			ang += 360.0
		end

		while (ang > 360.0) 
			ang -= 360.0
		end

		return ang
	end
	
	def calc_angle_diff(ang1, ang2)
		a1 = normalize_angle(ang1)
		a2 = normalize_angle(ang2)
		dif = a1 - a2
		dif = (dif < 0) ? -dif : dif
		dif = (dif > 180.0) ? (360.0-dif) : dif
		
		return dif
	end
end


anc = AngCalc.new
dif = anc.calc_angle_diff(359, 0)
p dif


#angles = [30, -21, 270, 450, -235]
#angles.each do |ang|
	#p ang
	#p (sprintf("%f => %f", ang.to_f, anc.normalizeAngle(ang.to_f)))
#end
#anc.normalizeAngle