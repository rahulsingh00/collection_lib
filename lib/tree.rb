class Tree

  attr_accessor :head

  class Node

    attr_accessor :element
    attr_reader :left, :right

    def initialize(obj)
      @children = Array.new(2)
      @element = obj
    end
    
    def left
      @children[0]
    end
    
    def right
      @children[1]
    end

    def left=(obj)
      if @element.class.eql?(obj.class)
        @children[0] = Node.new(obj)
      else
        raise "The type of elements doesn't match"
      end
    end

    def right=(obj)
      if @element.class.eql?(obj.class)
        @children[1] = Node.new(obj)
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

  def inorder_traversal(node, traversed_array=[])
    if !node.left.nil?
      inorder_traversal(node.left,traversed_array)
    end
    traversed_array << node.element
    if !node.right.nil?
      inorder_traversal(node.right,traversed_array)
    end
    return traversed_array
  end
  
  def preorder_traversal(node, traversed_array=[])
    traversed_array << node.element
    if !node.left.nil?
      preorder_traversal(node.left, traversed_array)
    end
    if !node.right.nil?
      preorder_traversal(node.right, traversed_array)
    end
    return traversed_array
  end
  
  def postorder_traversal(node, traversed_array=[])
    if !node.left.nil?
      postorder_traversal(node.left, traversed_array)
    end
    if !node.right.nil?
      postorder_traversal(node.right, traversed_array)
    end
    traversed_array << node.element
    return traversed_array
  end

end
