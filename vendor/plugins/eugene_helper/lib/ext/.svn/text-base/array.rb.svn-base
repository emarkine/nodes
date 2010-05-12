class Array
  
  def names
    self.collect do |o|
      o.name
    end
  end
  
  def median
    if length.odd?
      self[length / 2.0]
    else
      self[(length / 2 - 1)..(length / 2)].average
    end
  end
  
  def average
    sum / length
  end
end