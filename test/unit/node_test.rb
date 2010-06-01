require 'test_helper'

class NodeTest < ActiveSupport::TestCase

  test "add" do
    n = Node.new
    n.add({'a' => 1})
    puts "add: #{n}"
    assert n.size
  end

  test "add string" do
    n = Node.new({'a' => 1})
     n.add('b')
     puts "add string: #{n}"
     assert n.size
     assert_equal(n[1], {'b' => nil})
   end

  test "add in begin" do
    n = Node.new({'a' => 1})
    n.add({'b' => 2}, 0)
    puts "add in begin: #{n}"
    assert_equal(n[0], {'b' => 2})
    assert_equal(n[1], {'a' => 1})
  end

  test "add between" do
    n = Node.new({'a' => 1, 'b' => 2})
    n.add({'c' => 3}, 1)
    puts "add between: #{n}"
    assert_equal(n[0], {'a' => 1})
    assert_equal(n[1], {'c' => 3})
    assert_equal(n[2], {'b' => 2})
  end

  test "attr writer" do
    n = Node.new
    n.a = 1
    puts "attr writer: #{n}"
    assert_equal(n[0], {'a' => 1})
  end

  test "constructor" do
    n = Node.new({'a' => 1})
    puts "constructor: #{n}"
    assert_equal(n, {'a' => 1})
  end

  test "plus" do
    n = Node.new({'a' => 1})
    n += {'b' => 2}
    puts "plus: #{n}"
    assert_equal(n[0], {'a' => 1})
    assert_equal(n[1], {'b' => 2})
  end

  test "plus two" do
    n = Node.new({'a' => 1})
    n += {'b' => 2, 'c' => 3}
    puts "plus two: #{n}"
    assert_equal(n[0], {'a' => 1})
    assert_equal(n[1], {'b' => 2})
    assert_equal(n[2], {'c' => 3})
  end

  test "add_value" do
    n = Node.new( 'a')
    n.add_value 'a', 'v'
    puts "add_value: #{n}"
    assert_equal(n[0], {'a' => 'v'})
  end

  test "add_value by" do
    n = Node.new( 'a' => 'v1')
    n.add_value 'a', 'v2'
    puts "add_value: #{n}"
    assert_equal(n[0], {'a' => ['v1','v2'] } )
  end

  test "add_value in array" do
    n = Node.new( 'a' => ['v1', 'v2'] )
    n.add_value 'a', 'v3'
    puts "add_value in array: #{n}"
    assert_equal(n[0], {'a' => ['v1','v2', 'v3'] } )
  end

end
