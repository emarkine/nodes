module EugeneHelper

	include LinksHelper, FormsHelper

	# отображение логической переменной в виде чекбокса
	def b(v)
		if v
			"<img src='/images/true.gif' />"
		else
			"<img src='/images/false.gif' />"
		end
	end
	
end
