class Tree

  attr_accessor :head

  class Node

    attr_accessor :element, :children

    def initialize(obj, child_nodes = nil)
      @children = Array.new
      if !child_nodes.nil? && child_nodes.class.eql?(Array) && !child_nodes.empty?
        child_nodes.each do |node|
          if !node.class.eql?(Node)
            raise "You tried to enter a child which is not a proper node"
          else
            @children << node   
          end
        end
      end
      @element = obj
    end

  end


  def initialize(obj = nil, args = nil)
    if !obj.nil?
      if !args.nil? && args.class.eql?(Array) && !args.empty?
        args.each_with_index do |element,index|
          if !element.class.eql?(obj.class) 
           raise "The kind of elements you had passed do not match #{element.inspect}"
          end
          args[index] = Node.new(element)
        end
        @head = Node.new(obj,args)
      else
        @head = Node.new(obj)  
      end
    end
  end

  def empty?
    if !self.head.nil?
      false
    else
      true
    end
  end

end
