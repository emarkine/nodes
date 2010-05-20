require 'test_helper'

class NodeTest < ActiveSupport::TestCase

  test "add" do
    n = Node.new
		n.add( { 'a' => 1 } )
		puts "add: #{n}"
		assert n.size
  end

	test "constructor" do
		n = Node.new( { 'a' => 1 } )
		puts "constructor: #{n}"
		assert_equal(n, { 'a' => 1 } )
	end

	test "plus" do
		n = Node.new( { 'a' => 1 } )
		n += { 'b' => 2 }
		puts "plus: #{n}"
		assert_equal(n[0], { 'a' => 1 } )
		assert_equal(n[1], { 'b' => 2 } )
	end


	test "add in begin" do
		n = Node.new( { 'a' => 1 } )
		n.add( { 'b' => 2 }, 0 )
		puts "add in begin: #{n}"
		assert_equal(n[0], { 'b' => 2 } )
		assert_equal(n[1], { 'a' => 1 } )
	end

	test "add between" do
		n = Node.new( { 'a' => 1, 'b' => 2 } )
		n.add( { 'c' => 3 }, 1 )
		puts "add between: #{n}"
		assert_equal(n[0], { 'a' => 1 } )
		assert_equal(n[1], { 'c' => 3 } )
		assert_equal(n[2], { 'b' => 2 } )
	end

	test "attr writer" do
		n = Node.new
		n.a = 1
		puts "attr writer: #{n}"
		assert_equal(n[0], { 'a' => 1 } )
	end

end
