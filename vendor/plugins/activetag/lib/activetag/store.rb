module ActiveTag
	module Store
		def self.included(base)
			base.class_eval do
				include InstanceMethods
				extend ClassMethods

				cattr_accessor :_collection, :collection_name, :indexed
				self.collection_name = self.name.collectionize
				self.indexed = false

				delegate :collection, :db, :to => "self.class"

			end
		end


		module ClassMethods


			# Return the database associated with this class.
			def db
				collection.db
			end

			# Returns the collection associated with this +Document+. If the
			# document is embedded, there will be no collection associated
			# with it.
			#
			# Returns: <tt>Mongo::Collection</tt>
			def collection
				self._collection ||= ActiveTag.config.master[self.collection_name];
#				add_indexes
				self._collection
			end

			alias :coll :collection

			# Add the default indexes to the root document if they do not already
			# exist. Currently this is only _type.
			def add_indexes
				unless indexed
					self._collection.create_index(:_type, false)
					self.indexed = true
				end
			end


			# Returns all types to query for when using this class as the base.
			def _types
				@_type ||= (self.subclasses + [self.name])
			end

			def all
				list = []
				coll.find.each do |row|
					  list << Node.new(row)
				end
				list
			end

			def first
				Node.new(coll.find_one())
			end

			def last
				Node.new(coll.find.to_a[-1])
			end

		end

		module InstanceMethods

			def id
				self[:_id]
			end

			def id=(new_id)
				self[:_id] = new_id
			end

			alias :_id :id
			alias :_id= :id=

			def save
				Node.coll.save(self)
			end


		end


	end
end