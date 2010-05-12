class String

	def remove( srt )
		self.sub srt, ""
	end

	def remove!( srt )
		self.sub! srt, ""
	end

	alias :del :remove
	alias :del! :remove!

  # вывод стоки до данной подстроки, если ее нет, то возвращается сама строка
  def before(s)
    i = self.index s
    i ? self[0...i] : self 
  end

  # вывод стоки после данной подстроки, если ее нет, то возвращается nil
  def after(s)
    i = self.index s
		len = s.size
    i ? self[(i+len)..-1] : nil
  end
  
	# выделение из строки массива содержащегося между s1 и s2
	def between( s1, s2 )
		ss = self.split(s1) # режем на кусочки по s1
		ss = ss.collect do |c| # выбираем из них только те, где есть s2
			i = c.index s2 # определямем индекс вхождения
			c[0...i] if i # обрезаем хвосты
		end
		ss.compact # удаляем nil из массивы
	end

	# выделение из строки массива с содержанием тэга tag
	def tag( tag )
		between( "<#{tag}>", "</#{tag}>" )
	end

end