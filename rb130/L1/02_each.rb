# Example use:

# each([1, 2, 3, 4, 5]) do |num|
#   puts num
# end

def each(arr)
  counter = 0
  while counter < arr.size
    yield(array[counter])
    counter += 1
  end
  array
end