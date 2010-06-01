require "activetag/store"

#class Node < ActiveSupport::OrderedHash
class Node < Hash
  include ActiveTag::Store

  def initialize(hash=nil)
    add(hash)
  end

  # если в хэше есть ключ с такими именем, то возвращается его значение (или ему присваивается значение)
  def method_missing(name, * args)
    attr = name.to_s
    if attr.include?("=")
      # "args.size > 1" allows to simulate 1.8 behavior of "*args"
      self[attr.reader] = (args.size > 1) ? args : args.first
    else
      return super unless has_key?(attr.reader)
      self[attr.reader]
    end
  end

  def name
    return self["name"] if has_key? "name"
    "[#{id}]"
  end

    def vkeys
      vkeys = keys
      vkeys.delete '_id'
      vkeys
    end

#    def key
#      keys[0]
#    end
#
#    def key= k
#      self[k] ||= nil
#    end
#
#    def value
#      values[0]
#    end
#
#    def value= v
#      if size>0
#        self[0] ||= v
#      end
#    end

  # если передаается цифра, то возвращается хэш по этой позиции
  def [](pos)
    return super(pos) if pos.class != Fixnum
    {keys[pos] => values[pos]}
  end

  #  если передаается цифра, то установка хэша на позицию
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
    return unless hash && ((hash.kind_of? Hash) || (hash.kind_of? String))
    pos = size unless pos
    if self.empty?
      self[hash] = nil if hash.kind_of? String
      hash.each { |k, v| self[k] = v } if hash.kind_of? Hash
    else
      t = self.clone
      clear
      0.upto(t.size) do |i|
        if i == pos
          self[hash] = nil if hash.kind_of? String
          hash.each { |k, v| self[k] = v } if hash.kind_of? Hash
        end
        self[t.keys[i]] ||= t.values[i] if i < t.size
      end
    end
    self
  end

  # плюсиком тоже можно вводить хэши
  alias + add

  # уставка хэша (все бывшие значения сбрасываются)
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
