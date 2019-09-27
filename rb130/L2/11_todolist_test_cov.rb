require 'minitest/autorun'
require "minitest/reporters"
Minitest::Reporters.use!
require 'simplecov'
SimpleCov.start


require_relative '09_todolist'

class TodoListTest < MiniTest::Test

  def setup
    @todo1 = Todo.new("Buy milk")
    @todo2 = Todo.new("Clean room")
    @todo3 = Todo.new("Go to gym")
    @todos = [@todo1, @todo2, @todo3]

    @list = TodoList.new("Today's Todos")
    @list.add(@todo1)
    @list.add(@todo2)
    @list.add(@todo3)
  end

  # Your tests go here. Remember they must start with "test_"
  # to_a
  def test_to_a
    assert_equal(@todos, @list.to_a)
  end
  # size
  def test_size
    assert_equal(@todos.size, @list.size)
  end
  # first
  def test_first
    assert_equal(@todos.first, @list.first)
  end
  # last
  def test_last
    assert_equal(@todos.last, @list.last)
  end
  # shift
  def test_shift
    removed_item = @list.shift
    assert_equal(@todo1, removed_item)
    assert_equal(@todos[1..-1], @list.to_a)    
  end
  # pop
  def test_pop
    removed_item = @list.pop
    assert_equal(@todo3, removed_item)
    assert_equal(@todos[0..-2], @list.to_a)
  end
  # done?
  def test_done_question
    assert_equal(false, @list.done?)
  end
  # Write a test that verifies a TypeError is raised when adding an item into the list that's not a Todo object.
  def test_type_error
    # Long version
    # begin
    #   @list<<('none Todo object')
    # rescue TypeError => e
    #   assert_equal('can only add Todo objects', e.message)
    # end

    # Short version
    assert_raises(TypeError) { @list.add(1) }
    assert_raises(TypeError) { @list.add('hi') }
  end
  # <<
  def test_shovel
    @todos << @todo3
    @list << @todo3
    assert_equal(@todos, @list.to_a)
  end
  # add
  def test_add
    new_todo = Todo.new("Feed the cat")
    @list.add(new_todo)
    @todos << new_todo
    assert_equal(@todos, @list.to_a)
  end
  # item_at
  def test_item_at
    assert_raises(IndexError) { @list.item_at(100) }
    assert_equal(@todo1, @list.item_at(0))
    assert_equal(@todo2, @list.item_at(1))
  end
  # mark_done_at
  def test_mark_done_at
    assert_raises(IndexError) { @list.mark_done_at(100) }
    @list.mark_done_at(1)
    assert_equal(false, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(false, @todo3.done?)
  end
  # mark_undone_at
  def test_mark_undone_at
    assert_raises(IndexError) { @list.mark_undone_at(100) }
    @todo1.done!
    @todo2.done!
    @todo3.done!

    @list.mark_undone_at(1)

    assert_equal(true, @todo1.done?)
    assert_equal(false, @todo2.done?)
    assert_equal(true, @todo3.done?)
  end
  # done!
  def test_done_all
    @list.done!
    assert_equal(true, @todo1.done?)
    assert_equal(true, @todo2.done?)
    assert_equal(true, @todo3.done?)
    assert_equal(true, @list.done?)
  end
  # remove_at
  def test_remove_at
    assert_raises(IndexError) { @list.remove_at(100) }
    @list.remove_at(1)
    assert_equal([@todo1, @todo3], @list.to_a)
  end

  def test_to_s
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [ ] Clean room
    [ ] Go to gym
    OUTPUT
  
    assert_equal(output, @list.to_s)
  end

  def test_to_s_2
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [ ] Buy milk
    [X] Clean room
    [ ] Go to gym
    OUTPUT
  
    @list.mark_done_at(1)
    assert_equal(output, @list.to_s)
  end

  def test_to_s_3
    output = <<-OUTPUT.chomp.gsub /^\s+/, ""
    ---- Today's Todos ----
    [X] Buy milk
    [X] Clean room
    [X] Go to gym
    OUTPUT
  
    @list.done!
    assert_equal(output, @list.to_s)
  end

  # each
  def test_each
    num = 0
    @list.each { num +=1 }
    assert_equal(3, num)
  end
  
  # each return
  def test_each_returns_original_ist
    assert_equal(@list.to_a, @list.each {|todo| nil })
  end

  #select
  def test_select
    @todo1.done!
    list = TodoList.new(@list.title)
    list.add(@todo1)
  
    assert_equal(list.title, @list.title)
    assert_equal(list.to_s, @list.select{ |todo| todo.done? }.to_s)
  end
end