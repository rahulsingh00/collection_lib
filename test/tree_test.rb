require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + "/../lib/tree.rb"

class TreeTest < Test::Unit::TestCase
  def test_tree_is_empty
    tree = Tree.new
    assert tree.empty?
  end
  
  def test_tree_gets_created_with_children
    assert_nothing_raised(Exception) do
      tree = Tree.new(4,[1,2,3,5,6])
      assert tree.head.element, 4
      assert tree.head.children.size, 6
    end
  end
  
  def test_tree_doesnot_get_created
    assert_raise(RuntimeError) do
      Tree.new(4,[1,2,"5","7"])
    end
  end
  
end  
