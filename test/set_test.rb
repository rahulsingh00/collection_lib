require 'test/unit'
require File.expand_path(File.dirname(__FILE__)) + "/../lib/set.rb"

class SetTest < Test::Unit::TestCase
  def test_set_is_empty
    set = Set.new
    assert set.empty?
  end

  def test_set_is_not_empty
    set = Set.new("203","405")
    assert !set.empty?
  end

  def test_number_of_elements
    set = Set.new("405")
    assert_equal 1,set.size
  end

  def test_insertion_into_set
    set = Set.new("302","201")
    count1 = set.size
    assert_nothing_raised(Exception) do
      set.insert("406")
    end
    count2 = set.size
    assert_equal 1,(count2 - count1)
  end

  def test_insert_duplicate_element_into_set
    set = Set.new("302","201")
    count1 = set.size
    assert_raise(RuntimeError) do
      set.insert("302")
    end
    count2 = set.size
    assert_equal 0,(count2 - count1)
  end

  def test_insertion_of_different_data_types_into_set
    set = Set.new("302","201")
    count1 = set.size
    assert_raise(RuntimeError) do
      set.insert(406)
    end
    count2 = set.size
    assert_equal 0,(count2 - count1)
  end

  def test_remove_element_from_unempty_set
    set = Set.new("402","301")
    count1 = set.size
    assert_nothing_raised(Exception) do
      set.remove("402")
    end
    count2 = set.size
    assert_equal 1,(count1 - count2)
  end

  def test_remove_element_from_unempty_set_which_is_not_there
    set = Set.new("402","301")
    count1 = set.size
    assert_raise(RuntimeError) do
      set.remove("405")
    end
    count2 = set.size
    assert_equal 0,(count1 - count2)
  end

  def test_remove_element_from_empty_set
    set = Set.new()
    count1 = set.size
    assert_raise(RuntimeError) do
      set.remove("405")
    end
    count2 = set.size
    assert_equal 0,(count1 - count2)
  end

  def test_whether_one_set_is_subset_of_another
    set1 = Set.new("1","2","3","4","5")
    set2 = Set.new("3","2","5")
    assert_nothing_raised(Exception) do
      assert set2.subset_of?(set1)
      assert set1.superset_of?(set2)
    end
  end

  def test_negative_case_one_of_subset
    set1 = Set.new("1","2","3","4","5")
    set2 = Set.new("3","2","6")
    assert_nothing_raised(Exception) do
      assert !set2.subset_of?(set1)
      assert !set1.superset_of?(set2)
    end
  end

  def test_negative_case_two_of_subset
    set1 = Set.new("1","2","3","4","5")
    set2 = Set.new("3","2","1","4","5","6")
    assert_nothing_raised(Exception) do
      assert !set2.subset_of?(set1)
      assert !set1.superset_of?(set2)
    end
  end

  def test_subset_property_for_different_types_of_sets
    set1 = Set.new("1","2","3","4","5")
    set2 = Set.new(3,1,2)
    assert_raise(RuntimeError) do
      set2.subset_of?(set1)
    end
  end

  def test_intersection_of_sets
    set1 = Set.new("1","2","3")
    set2 = Set.new("1","3","5","7")
    assert_nothing_raised(Exception) do
      set1.intersection(set2)
    end
    set3 = set1.intersection(set2)
    assert_equal 2,set3.size
    assert set3.elements.include?("1")
    assert set3.elements.include?("3")
  end

  def test_intersection_of_sets_of_different_kinds
    set1 = Set.new("1","2","3")
    set2 = Set.new(1,3,5,7)
    assert_raise(RuntimeError) do
      set1.intersection(set2)
    end
  end

  def test_idempotent_law_for_intersection
    set1 = Set.new("1","2","3")
    set2 = Set.new
    assert_nothing_raised(Exception) do
      set1.intersection(set2)
    end
    assert set1.intersection(set2).empty?
  end

  def test_union_of_a_sets
    set1 = Set.new("1","2","3")
    set2 = Set.new("5","3","1","4")
    set3 = Set.new
    assert_nothing_raised(Exception) do
      set3 = set1.union(set2)
    end
    assert set1.subset_of?(set3)
    assert set2.subset_of?(set3)
  end

  def test_union_of_a_sets_of_different_types
    set1 = Set.new("1","2","3")
    set2 = Set.new(2,5,3,6,7)
    assert_raise(RuntimeError) do
      set1.union(set2)
    end
  end

  def test_idempotent_law_for_union
    set1 = Set.new("1","2","3")
    set2 = Set.new
    assert_nothing_raised(Exception) do
      set1.union(set2)
    end
    assert_equal set1,set1.union(set2)
  end

  def test_commutative_law_for_intersection
    set1 = Set.new("1","2","3")
    set2 = Set.new("1","3","5","7")
    assert_nothing_raised(Exception) do
      set1.intersection(set2)
      set2.intersection(set1)
    end
    assert set1.intersection(set2).equal?(set2.intersection(set1))
  end

  def test_commutative_law_for_union
    set1 = Set.new("1","2","3")
    set2 = Set.new("5","3","1","4")
    assert_nothing_raised(Exception) do
      set1.union(set2)
      set2.union(set1)
    end
    set1.union(set2).equal?(set2.union(set1))
  end

  def test_should_test_clear
    set1 = Set.new("1","2","3")
    set1.clear
    assert set1.empty?
  end

  def test_add_array_of_elements_to_set
    set = Set.new(1,2,3)
    assert_nothing_raised(Exception) do
      set.add([4,5,6])
    end
    assert set.size, 6
  end

  def test_negative_case_one_add_array_of_elements_to_set
    set = Set.new(1,2,3)
    assert_raise(RuntimeError) do
      set.add([4,3])
    end
  end

  def test_negative_case_two_add_array_of_elements_to_set
    set = Set.new(1,2,3)
    array = ["4","5","6"]
    assert_raise(RuntimeError) do
      set.add(array)
    end
  end

  def test_positive_constructor_with_condition
    cond = lambda {|x| x%2 == 0 ? true : false}
    set = Set.new(2,4,6,cond)
    assert set.size, 3
  end

  def test_negative_constructor_with_condition
    cond = lambda {|x| x%2 == 0 ? true : false}
    assert_raise(RuntimeError) do
      Set.new(2,4,7,cond)
    end
  end

  def test_positive_case_for_minus
    set1 = Set.new(1,2,3,4,5,6)
    set2 = Set.new(4,6,7,8,9)
    assert_nothing_raised(Exception) do
      set1.minus(set2)
      set2.minus(set1)
    end
    assert set1.minus(set2).size,4
    assert set2.minus(set1).size,3
  end

  def test_negative_case_for_minus
    set1 = Set.new(1,2,3,4,5,6)
    set2 = Set.new("4","6","7","8","9")
    assert_raise(RuntimeError) do
      set1.minus(set2)
    end
  end
end