class Element
  attr_reader :datum
  attr_accessor :next
  def initialize(num, next_el = nil)
    @datum = num
    @next = next_el
  end

  def tail?
    true if @next == nil
  end
end

class SimpleLinkedList
  def self.from_a(arr)
    linked_list = self.new()
    arr.to_a.reverse.each { |item| linked_list.push(item) }
    linked_list
  end

  def initialize(arr = [])
    @array = arr
  end

  def push(el)
    @array.insert(0, Element.new(el))
    @array.each_with_index do |el, i|
      el.next = @array[i+1] unless i - 1 == @array.size
    end
  end

  def pop
    return_element = @array.shift
    @array.each_with_index do |el, i|
      el.next = @array[i+1] unless i - 1 == @array.size
    end
    return_element.datum
  end

  def peek
    head&.datum
  end

  def size
    @array.size
  end

  def empty?
    @array.empty?
  end

  def head
    @array[0]
  end

  def to_a
    @array.map { |el| el.datum }
  end

  def reverse
    self.class.from_a(@array.reverse.map(&:datum))
  end
end