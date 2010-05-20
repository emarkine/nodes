require "activetag/store"

class Node < OrderedHash
	include ActiveTag::Store


	# Used for allowing accessor methods for dynamic attributes.
	def method_missing(name, * args)
		attr = name.to_s
		if attr.writer?
			# "args.size > 1" allows to simulate 1.8 behavior of "*args"
			self[attr.reader] = (args.size > 1) ? args : args.first
		else
			return super unless has_key?(attr.reader)
			self[attr.reader]
		end
	end

	def [](key)
		return super(key) if key.class != Fixnum
		{@ordered_keys[key], self[@ordered_keys[key]]}
	end

	def []=(num, hash)
		return super(num, hash) if num.class != Fixnum
		@ordered_keys[num] = hash.keys[0]
		self[hash.keys[0]] = hash.values[0]
	end

	def add(hash)
		hash.each do |k, v|
			self[k] = v
		end
	end



end
