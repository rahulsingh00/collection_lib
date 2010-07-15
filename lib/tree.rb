class Tree

  attr_accessor :head

  class Node

    attr_accessor :element
    attr_reader :left, :right

    def initialize(obj)
      @left = nil
      @right = nil
      @element = obj
    end

    def left=(obj)
      if @element.class.eql?(obj.class)
        @left = Node.new(obj)
      else
        raise "The type of elements doesn't match"
      end
    end

    def right=(obj)
      if @element.class.eql?(obj.class)
        @right = Node.new(obj)
      else
        raise "The type of elements doesn't match"
      end
    end

  end

  def initialize(obj = nil)
    if !obj.nil?
      @head = Node.new(obj)
    end
  end

  def empty?
    if !self.head.nil?
      false
    else
      true
    end
  end

  def traversal1(node)
    if !node.left.nil?
      traversal1(node.left)
    end
    puts node.element
    if !node.right.nil?
      traversal1(node.right)
    end
  end

  def insert(array,index,current_node)
    if (2*index + 1) <= (array.size - 1)
      current_node.left = array[2*index + 1]
      insert(array,(2*index + 1),current_node.left)
    end
    if (2*index + 2) <= (array.size - 1)
      current_node.right = array[2*index + 2]
      insert(array,(2*index + 2),current_node.right)
    end
  end
  
  def add(array)
    if array.class.eql?(Array) && @head.nil?
      @head = Node.new(array[0])
      insert(array,0,@head)
    else
      raise "The add function only accepts an array as an argument"
    end
  end

end
