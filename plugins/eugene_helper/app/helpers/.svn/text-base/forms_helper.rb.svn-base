module FormsHelper

	# выводим просмотр поля в тавблице зависимости от его типа
	def view_field(o, name, type = nil)
		value = o.send name # получаем значение поля
#		association = o.class.reflect_on_association(name) # берем ассощиации для этого имени
		if value.class.superclass == ActiveRecord::Base # это один из классов модели
			show_link value
		else
			case type
#				when :currency
#					value.to_s("2F")
#					number_to_currency(value, :unit => "", :separator => ",", :delimiter => ".")
#					"&euro; "+ value.to_s
				when :percent
					value.to_s + " %" if value && value > 0
				when :file
					file_link o, name
				when :boolean
					b value
				when :date
					value.strftime("%d %B %Y") if value
				when :table
#					association = o.class.reflect_on_association(name)
					klass = Class.instance_eval "#{name.to_s.capitalize}Controller"
					attrs = klass.config.send "index"
					render :partial => "objects/table", :locals => { :attrs => attrs, :objs => value }
				else # если не определен
					case value.class.name
						when 'Array'
							show_links value
						when "Date"
							value.strftime("%d %B %Y")
						when "Time"
							value.strftime("%H:%M:%S")
						when "ActiveSupport::TimeWithZone"
							value.strftime("%d-%m-%Y %H:%M:%S")
						else
							value
					end
			end
		end
	end


	def form_field( f, a )
		name = a.name
		type = a.type
		if name == :password # в случае поля под названием пароль стороим двойной ввод с подтверждением
			s = f.password_field :password, :size => (a.size ? a.size : 10)
			s += "&nbsp;"
			s += f.password_field :password_confirmation, :size => (a.size ? a.size : 10)
			return s
		end
		if name == :access # в случае поля под названием access строим форму access
			return render :partial => 'application/access', :object => f.object
		end

		o = f.object # объет для которого все строится
		case type # смотрим переданный тип
			when :integer
				f.text_field name, :size => (a.size ? a.size : 3)
			when :boolean
				f.check_box name
			when :file
				return render :partial => 'objects/upload', :object => f, :locals => { :attr => a }
#				f.file_field name, :class => 'file'
			when :date
				f.text_field name,	:class => 'date', :size => (a.size ? a.size : 11)
			when :text
				f.text_area name, :size => "50x10"
			when :hidden
				f.hidden_field name
			when :currency
				f.text_field  name, :size => (a.size ? a.size : 8)
			else # если тип не определен
				association = o.class.reflect_on_association(name) # берем ассощиации для этого имени
				if	association #  это поле не простое!
					if association.macro == :belongs_to # здесь надо будет построить select
						klass = Class.instance_eval association.class_name # получаем класс ассоциации
						begin
							list = klass.list # пытаемся получит список (если он определен специально)
						rescue
							list = klass.all :order => :name # список всех значений класса по алфавиту
						end
						value = o.send name # получаем для поля значение
						if value && !list.index(value)
							  list << value  # и добавляем в список, если его там нет и оно не нулевое
						end
						f.collection_select "#{name}_id", list, :id, :name, { :include_blank => true }
					end
				else #  теперь для простых полей
					value = o.send name # получаем для него значение
					class_name = value.class.name # получаем класс поля
					# TODO зделать его получение человеческим образом!
					case class_name
						when 'Array'
							# TODO надо будет вынести ассоциацию has_many в отдельные блоки ниже основной формы, а пока ничего...
#					return render :partial => 'application/list', :object => value
						when 'Fixnum'
							f.text_field name, :size => (a.size ? a.size : 2)
						else
							f.text_field name, :size => a.size
					end
				end
		end
	end

end