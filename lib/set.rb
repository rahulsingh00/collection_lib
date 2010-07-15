class Set
  attr_accessor :elements
  
  def initialize(*objs)
    @elements = Array.new
    if objs[-1].class.eql?(Proc) && objs[-1].arity == 1
      @condition = objs[-1]
      objs[0...-1].each {|x| insert(x)}
    else
      objs.each {|obj| insert(obj)}
    end
  end
  
  def empty?
    if self.elements.size == 0
      true
    else
      false
    end
  end

  def size
    self.elements.size
  end

  def insert(obj)
    if !empty?
      if obj.class.eql?(self.elements[0].class) && !duplicate?(obj)
        if @condition && @condition.call(obj)
          self.elements << obj
        elsif @condition && !@condition.call(obj)
          raise "#{obj.inspect} does not match the given condition"
        else
          self.elements << obj
        end
      elsif obj.class.eql?(self.elements[0].class) && duplicate?(obj)
        raise "The object you are trying to insert is already there in the set"
      else
        raise "You cannot insert different elements into a set"
      end
    else
      self.elements << obj
    end
  end

  def remove(obj)
    if !empty?
      if obj.class.eql?(self.elements[0].class) && self.elements.include?(obj)
        self.elements = self.elements - [obj]
      else
        raise "You are trying to remove an object which is not contained in the set"
      end
    else
      raise "You cannot remove anything from an empty set"
    end
  end

  def subset_of?(set)
    if self.elements[0].class.eql?(set.elements[0].class) && self.size > set.size
      return false
    elsif self.elements[0].class.eql?(set.elements[0].class) && self.size <= set.size
      val = true
      self.elements.each do |element|
        if !set.elements.include?(element)
          val = false
          break
        end
      end
      return val
    else
      raise "You are comparing two sets of different kinds"
    end
  end

  def superset_of?(set)
    if set.subset_of?(self)
      true
    else
      false
    end
  end

  def intersection(set)
    if self.empty? or set.empty?
      return Set.new
    else
      if self.elements[0].class.eql?(set.elements[0].class)
        new_set = Set.new
        self.elements.each do |element|
          if set.elements.include?(element)
            new_set.insert(element)
          end
        end
        return new_set
      else
        raise "You are trying intersection of sets with different types of elements"
      end
    end
  end

  def union(set)
    if self.empty? or set.empty?
      return self
    else
      if self.elements[0].class.eql?(set.elements[0].class)
        new_set = Set.new
        new_set.elements = (self.elements + set.elements).uniq!
        return new_set
      else
        raise "You are trying union of sets with different types of elements"
      end
    end
  end

  def equal?(set)
    if self.empty? && set.empty?
      return true
    else
      if self.size != set.size
        return false
      else
        if self.elements[0].class.eql?(set.elements[0].class)
          val = true
          self.elements.each do |element|
            if !set.elements.include?(element)
              val = false
              break
            end
          end
          return val
        else
          raise "You are comparing two sets of different types"
        end
      end
    end
  end

  def clear
    self.elements = []
  end

  def add(array)
    if array.class.eql?(Array) && array.size > 0
      array.each do |x|
        self.insert(x)
      end
    else
      raise "The argument is wrong."
    end
  end

  def minus(set)
    intersected_set = self.intersection(set)
    set = Set.new
    set.add(intersected_set.elements)
  end

  private
  
  def duplicate?(obj)
    if self.elements.include?(obj)
      true
    else
      false
    end
  end
end