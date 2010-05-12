class Date
 
	def days_in_year
#		d = 0;
#		1.upto(12) do |m|
#			d += Time.days_in_month(m,self.year)
#		end
#		d
		Date.parse("#{self.year}-12-31").strftime("%j").to_i
	end

	def day_in_year
		self.strftime("%j").to_i
#		first = Date.parse("#{self.year}-01-01")
#		days = days_in_year
#		1.upto(days) do |n|
#			d = first + n.days
#			return n if d == self
#		end
	end

end