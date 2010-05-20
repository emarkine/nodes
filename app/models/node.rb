require "activetag/store"

class Node < Hash
	include ActiveTag::Store

	def initialize(hash=nil)
		add(hash)
	end


	def [](pos)
		return super(pos) if pos.class != Fixnum
		{keys[pos] => values[pos]}
	end

	def []=(pos, hash)
		return super(pos, hash) if pos.class != Fixnum
		t = self.clone
		clear
		0.upto(t.size-1) do |i|
			if i == pos
				self[hash.keys[0]] = hash.values[0]
			else
				self[t.keys[i]] ||= t.values[i]
			end
		end
	end


	# вставка хэша в произвольную позицию (по умолчанию в конец)
	def add(hash, pos=nil)
		if hash.kind_of? Hash
			pos = size unless pos
			t = self.clone
			clear
			0.upto(t.size) do |i|
				hash.each { |k, v| self[k] = v } if i == pos
				self[t.keys[i]] ||= t.values[i] if i < t.size
			end
		end
		self
	end

	alias + add

	def set(hash)
		clear
		add(hash)
	end


end


#def [](key)
#	return super(key) if key.class != Fixnum
#	{@ordered_keys[key], self[@ordered_keys[key]]}
#end
#
#def []=(pos, hash)
#	return super(pos, hash) if pos.class != Fixnum
#	old_key = @ordered_keys[pos]
#	if old_key
#		delete old_key
#		key = hash.keys[0]
#		self[key] = hash.values[0]
#		(size-1).downto(pos) do |i|
#			@ordered_keys[i] = @ordered_keys[i-1]
#		end
#		@ordered_keys[pos] = key
#	end
#end
