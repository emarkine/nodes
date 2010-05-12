class Time

	def add_time_now
		now = Time.now
		mktime(self.year, self.month, self.day, now.hour, now.min, now.sec)
	end

	def days_in_year
		Date.parse("#{self.year}-12-31").strftime("%j").to_i
	end

	def day_in_year
		self.strftime("%j").to_i
	end

end