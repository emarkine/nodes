module LinksHelper

	# имя которое отображается на линках (если оно пусто или его нет - то id)
	# если перередан атрибут, то он вызывется вместо поля name
	def vname(obj, attr = nil)
		attr = 'name' unless attr
		begin
			name = obj.send attr
		rescue
			name = "[#{obj.id}]"
		end
#		name = obj.send attr if obj.has_attribute? attr
#		name = "[#{obj.id}]" if name.blank?
		name
	end

	def index( model )
		link_to model.pluralize.capitalize,
						{:controller => model.pluralize,
						:action => 'index'},
						{ :class => 'navigate' }
	end


	# вывод списка линков (в рядочек)
	def show_links(array, attr = nil)
		s = ""
		array.each do |o|
			s += show_link(o,attr) + " / "
		end
		s = s[0...-3] unless array.empty?
	end

	# линк на просмотр объекта
	def show_link(obj, attr = nil)
		return '&nbsp;' unless obj
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		name = vname(obj,attr)
		link_to name,
						{
							:controller => controller,
							:action => :show,
							:id => obj.id
						},
						{
							:class => 'action',
							:title => "Show #{class_name} '#{name}'",
							:onfocus => "this.blur()"

						}
	end

	# линк на загрузку файла
	def file_link(obj, attr)
		name = obj.send attr
		return '&nbsp;' unless name # нет файла - нечего делать
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		link_to name,
						{
							:controller => controller,
							:action => attr,
							:id => obj.id
						},
						{
							:class => 'action',
							:title => "File '#{name}'",
							:onfocus => "this.blur()"

						}
	end

	# линк на редактирование объекта
	def edit_link(obj, attr = nil)
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		name = vname(obj,attr)
		link_to name,
						{
							:controller => controller,
							:action => :edit
						},
						{
							:class => 'action',
							:title => "Edit '#{name}'",
							:onfocus => "this.blur()"

						}
	end

	# линк на создание объекта
	def create_link(name, title = nil)
		controller = name.downcase.pluralize
		title = name unless title
		link_to title,
						{
							:controller => controller,
							:action => :new
						},
						{
							:class => 'action',
							:title => "Create New #{title.singularize}",
							:onfocus => "this.blur()"

						}
	end

	# линк на удаление объекта
	def delete_link(obj, attr = nil)
		name =
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		name = vname(obj,attr)
		link_to name, obj,
						{
							:controller => controller,
							:method => :delete,
							:confirm => "Are you sure to delete #{class_name} '#{name}'&nbsp;?",
							:title => "Delete #{class_name} '#{name}'",
							:class => 'action',
							:onfocus => "this.blur()"
						}
	end

	def create(name)
		controller = name.downcase.pluralize
		link_to image_tag("create.gif",	:title => "Create New #{name}" ),
						{
							:controller => controller,
							:action => :new
						},
						{
							:class => 'action',
							:onfocus => "this.blur()"
						}
	end

	def edit(obj)
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		name = vname(obj)
		link_to image_tag("edit.gif", :title => "Edit #{name}"),
						{ :controller => controller,
							:action => :edit,
							:id => obj.id },
						{ :class => 'action',
							:onfocus => "this.blur()" }
	end

	def delete(obj)
		class_name = obj.class.name
		controller = class_name.downcase.pluralize
		name = vname(obj)
		link_to image_tag("delete.gif", :title => "Delete #{name}"), obj,
						{
							:controller => controller,
							:method => :delete,
							:confirm => "Are you sure to delete #{class_name} #{name}&nbsp;?",
							:class => 'action',
							:onfocus => "this.blur()"
						}
	end

	alias :destroy :delete

	def link(obj)
		return '&nbsp;' unless obj
		case obj.class
			when String.class
				"<a href='#{obj}' target='#{obj}'>#{obj}</a>"
			else
				name = obj.name if obj.has_attribute? 'name'
				ref = obj.url if obj.has_attribute? 'url'
				ref = "http://#{name}" unless ref
				"<a href='#{ref}' target='#{name}'>#{name}</a>"
		end
	end


end