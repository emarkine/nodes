require "activetag/store"

class Node < OrderedHash
	include ActiveTag::Store

	def initialize(hash=nil)
		add(hash)
	end

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

	def []=(pos, hash)
		return super(pos, hash) if pos.class != Fixnum
		old_key = @ordered_keys[pos]
		if old_key
			delete old_key
			key = hash.keys[0]
			self[key] = hash.values[0]
			(size-1).downto(pos) do |i|
				@ordered_keys[i] = @ordered_keys[i-1]
			end
			@ordered_keys[pos] = key
		end
	end

	def add(hash)
		if hash.kind_of? Hash
			hash.each do |k, v|
				self[k] = v
			end
		end
	end

	def set(hash)
		clear
		add(hash)
	end


end
