# Example use:

# each([1, 2, 3, 4, 5]) do |num|
#   puts num
# end

def each(arr)
  counter = 0
  while counter < arr.size
    yield(arr[counter])
    counter += 1
  end
  arr
end


each([1, 2, 3, 4, 5]) do |num|
  puts num
end




# 21.01.31 EXPANDED INTO HASHES
def each(obj)
  # determine the object type
  # start iterating over each value (or pair)
  iter = 0
  limit = obj.is_a?(Hash) ? obj.keys.length : obj.length
  # yield the block acccordingly (hash or array)
  if obj.is_a?(Hash)
    keys = obj.keys
    values = obj.values
    while iter < limit do
      yield(keys[iter], values[iter]) if block_given?
      iter += 1
    end
  elsif obj.is_a?(Array)
    while iter < limit do
      yield(obj[iter]) if block_given?
      iter += 1
    end
  end
  # Return the original array or hash
  return obj
end


each([1, 2, 3, 4, 5]) do |num|
  puts num
end

each({a: 4, b: 3, c: 7}) do |key, value|
  puts key, value
end

