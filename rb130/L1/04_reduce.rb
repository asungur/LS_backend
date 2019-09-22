def reduce(array, arg = array[0])
  i = arg == array[0] ? 1 : 0
  acc = arg
  
  while i < array.size
    acc = yield(acc, array[i])
    i += 1
  end
  acc
end

array = [1, 2, 3, 4, 5]

p reduce(array) { |acc, num| acc + num }                # => 15
p reduce(array, 10) { |acc, num| acc + num }            # => 25
# p reduce(array) { |acc, num| acc + num if num.odd? }    # => NoMethodError: undefined method `+' for nil:NilClass

# TESTS FOR EXTRA FEATURES

p reduce(['a', 'b', 'c']) { |acc, value| acc += value }     # => 'abc'
p reduce([[1, 2], ['a', 'b']]) { |acc, value| acc + value } # => [1, 2, 'a', 'b']
p reduce(array, 1) { |acc, num| acc + num }