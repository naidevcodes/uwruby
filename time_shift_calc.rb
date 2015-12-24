class TimeShift 

	def initialize time, min
		@time = time.split(/[:\s]/)
		@min = min
	end

	def add_time
		hh = @time[0].to_i
		mm = @time[1].to_i
		mm += @min
		meridian = @time[2].upcase

		xtra_hours = (@time[2].upcase == "PM") ? 720 : 0

		total_min = xtra_hours + (hh * 60) + mm

		meridian = 
			(total_min.between?(720, 1439)) ? "PM" : "AM"

		while mm > 59
			hh += 1 
			mm -= 60   

			if hh > 12
				hh -= 12

			end
		end

		printf "%d:%02d %s", hh, mm, meridian

	end

end

# puts TimeShift.new("11:50 PM", 60).add_time
# puts TimeShift.new("11:55 PM", 5).add_time
puts TimeShift.new("1:22 PM", 720).add_time