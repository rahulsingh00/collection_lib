require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + "/../lib/tree.rb"

class TreeTest < Test::Unit::TestCase
  def test_tree_is_empty
    tree = Tree.new
    assert tree.empty?
  end

  def test_tree_is_not_empty
    tree = Tree.new(1)
    assert !tree.empty?
  end

  def test_insert_element_in_left_node_positive_case
    tree = Tree.new(2)
    assert_nothing_raised(Exception) do
     tree.head.left = 1
     assert !tree.head.left.nil?
     assert tree.head.right.nil?
    end
  end

  def test_insert_element_in_left_node_negative_case
    tree = Tree.new(2)
    assert_raise(RuntimeError) do
     tree.head.left = "1"
    end
  end

  def test_insert_element_in_right_node_positive_case
    tree = Tree.new(2)
    assert_nothing_raised(Exception) do
     tree.head.right = 3
     assert !tree.head.right.nil?
     assert tree.head.left.nil?
    end
  end

  def test_insert_element_in_right_node_negative_case
    tree = Tree.new(2)
    assert_raise(RuntimeError) do
     tree.head.right = "3"
    end
  end

  def test_insert_element_via_array
    tree = Tree.new
    tree.add([0,1,2,3,4,5,6,7])
    tree.traversal1(tree.head)
  end
  
end