class Node
  include Mongoid::Document

	validates_presence_of :name
	validates_uniqueness_of :name
	
  field :name
	embedded :tags

end
