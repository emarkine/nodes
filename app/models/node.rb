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

  # список всех значений в виде массива
  def vs(key = nil)
    return super.values unless key
    return [] unless self[key] # у нас нет значения
    unless self[key].kind_of? Array # у нас есть уже значение, но оно одно и не в массиве
      return [] << self[key]
    end
    return self[key]
  end

  # добавляем значение в конец
  def add_value(key, value)
    return self[key] = value unless self[key] # если такого значения нет - то просто добавляем его без заморочек
    unless self[key].kind_of? Array # у нас есть уже значение, но оно одно и не в массиве
      v = self[key]   # сохраняем значение
      self[key] = []  # создаем массив
      self[key] << v  # добавляем значени
    end
    self[key] << value # добавляем значение в конец массива
  end

  # удаление значения на позиции index
  def delete_value(key,  index=nil)
    vs = self.vs key  # берем массив значений
    return self if vs.empty? # не из чего удалять
    index = vs.size-1 unless index # если не передана позиция, то устанавливаем ее в конец
    vs.delete_at index # удаляем значени
    return self[key] = nil if vs.empty? # если пусто, то чистим
    return self[key] = vs[0] if vs.size == 1 # если один элемент, то убираем массив
    return self[key] = vs # иначе все оставляем как есть
  end

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
