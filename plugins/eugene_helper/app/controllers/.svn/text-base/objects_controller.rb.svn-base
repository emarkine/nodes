module ObjectsController

	class Attribute
		attr_accessor :name
		attr_accessor :label
		attr_accessor :type
		attr_accessor :size

		def initialize(name, inst = nil)
			self.name = name
			self.label = inst[:label] if inst && inst[:label]
			self.label = name.to_s.humanize unless self.label
			self.type = inst[:type] if inst && inst[:type]
			self.type = :none unless self.type
			self.size = inst[:size] if inst && inst[:size]
		end

	end

	class Config
		attr_accessor :model
		attr_accessor :controller
		attr_accessor :klass
		attr_accessor :layout

		attr_accessor :attrs
		attr_accessor :all

		attr_accessor :index
		attr_accessor :show
		attr_accessor :edit
		attr_accessor :new

		# создаем атрибуты и присаваиваем их 4 типам контроллеров
		def make
			attrs = Hash.new
			if self.attrs
				self.attrs.each do |name, inst|
					a = Attribute.new name, inst
					attrs[name] ||= a
				end
			end
			self.attrs = attrs
			attach(:index)
			attach(:show)
			if !self.new && self.edit # если new не определен, но определен edit, то для new используем edit
				attach(:edit)
				self.new = self.edit
			else # иначе все идет стандартным путем
				attach(:edit)
				attach(:new)
			end
		end

		# определяем есть ли атрибут и вызываем или его родной преобразователь или all
		def attach(attr_name)
			atrs = self.send attr_name # вызываем этот атрибут
			if atrs.blank? # если он пуст
				atrs = attach_attr(self.all) # то берем данные из all
			else
				atrs = attach_attr(atrs) # иначе из его родного массива
			end
			self.send("#{attr_name}=".to_sym, atrs) # устанавливаем значение для этого отрибута
			atrs
		end

		# преобразователь для атрибута
		def attach_attr(src)
			as = Array.new
			src.each do |name| # проходим по всем переданным именам
				a = self.attrs[name] # берем атрибут из уже имеющегося
				a = Attribute.new name unless a # если его нет, но конструируем новый
				self.attrs[name] ||= a # присваиваем атрибут
				as << a # добавляем в массив
			end
			as
		end

	end


	#	установка переменных, которых будет удобно недлинно вызывать
	def set_params
		@model = self.class.config.model # имя модели
		@class = self.class.config.klass # класс
		case @action_name
			when 'index', 'show', 'edit', 'new', 'create', 'update', 'destroy' # если не передана специфическая акция
				@object_controller = true # флаг для render
			else
				@object_controller = false # флаг для render
		end
	end

	# render для специфического views/objects
	def render(options = nil, deprecated_status = nil, &block)
		if @object_controller
#		case @action_name
#			when 'index', 'show', 'edit', 'new', 'create', 'update', 'destroy' # если не передана специфическая акция
			@attrs = self.class.config.send @action_name # устанавливаем атрибуты
			# конструируем имя файла для этой action
			filename = File.join(Rails.root, "app/views/#{self.class.config.controller}/#{@action_name}.html.erb")
			if File.exist? filename # ели он особо присутствует в контроллере, то рисуем его
				super :layout => self.class.config.layout, :file => filename
			else # иначе общие отрисовчики для объектов
				super :layout => self.class.config.layout, :partial => "objects/#{@action_name}"
			end
		else
			if options.blank?
				super &block
			elsif deprecated_status.blank?
				super options, &block
			else
				super options, deprecated_status, &block
			end
		end
	end

	def index
		@objs = @class.send :all
	end

	def show
		@obj = @class.send :find, params[:id]
	end

	def new
		if params[:id]
			@src = @class.send :find, params[:id]
			@obj = @src.clone
		else
			@obj = @class.send :new unless @obj
		end
	end

	def edit
		@obj = @class.send :find, params[:id]
	end

	def create
		@obj = @class.send :new, params[@model]
		if @obj.send :save
			flash[:notice] = "#{@model.humanize} was created"
			redirect_to :action => 'show', :id => @obj
		else
			@action_name = 'new'
		end
	end

	def update
		@obj = @class.send :find, params[:id] unless @obj
		if @obj.send :update_attributes, params[@model]
			flash[:notice] = "#{@model.humanize} was updated"
			redirect_to :action => 'show'
		else
			@action_name = 'edit'
		end
	end

	def destroy
		@obj = @class.send :find, params[:id]
		@obj.send :destroy
		redirect_to :action => 'index'
	end


	# при включении этого блока добавятся методы из подблока ClassMethods
	def self.included(base)
		base.extend(ClassMethods)
	end

	module ClassMethods

		# инициализация модели
		def init(model, &block)

			# добавляем в вызвавший класс атрибут класса config
			class << self
				attr_accessor :config
			end

			config = Config.new #  создаем объкт для хранения настроек
			self.config = config # присваеваем его вызвавшему классу

			config.model = model.to_s # на всякий случай, если модель передана как symbol, переведем его в строку
			config.controller = config.model.pluralize # инициализируем имя контроллера
			config.klass = Class.instance_eval config.model.capitalize # инициализируем класс модели

			block.call config # все что передавали в блоке запишется в config
			config.make # заполняем поля атрибутов

			config.layout = "application" unless config.layout # если не был установлени layout то он будет application

			self.append_before_filter :set_params # добавляем фильтер установки перед любым вызовом

		end
	end


end