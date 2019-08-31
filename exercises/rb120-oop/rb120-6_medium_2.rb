class FixedArray
  def initialize(size)
    @array = Array.new(size)
    @size = size
  end
  
  def []=(index, item)
    if in_array_range?(index)
      @array[index] = item
    else
      raise IndexError
    end
  end

  def [](index)
    if in_array_range?(index)
      @array[index]
    else
      raise IndexError
    end
  end

  def to_a
    @array.dup
  end
  
  def to_s
    @array.to_s
  end

  private

  attr_reader :size
  def in_array_range?(index)
    (-size...size).cover?(index)
  end
end

# Define a class above that all conditions below return true

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end