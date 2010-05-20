class Node < OrderedHash
  include ActiveTag::Document

#  validates_presence_of :name
#  validates_uniqueness_of :name

#  field :name



 # embedded :tags

	def save
		  self
	end

	def id
		self["_id"]
	end


end
