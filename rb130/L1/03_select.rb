# array = [1, 2, 3, 4, 5]

# array.select { |num| num.odd? }       # => [1, 3, 5]
# array.select { |num| puts num }       # => [], because "puts num" returns nil and evaluates to false
# array.select { |num| num + 1 }        # => [1, 2, 3, 4, 5], because "num + 1" evaluates to true


def select(arr)
  return_arr = []
  iter = 0
  while iter < arr.length do
    if block_given?
      return_arr << arr[iter] if !!yield(arr[iter])
    end
    iter += 1
  end
  return_arr
end


# TEST

array = [1, 2, 3, 4, 5]

p select(array) { |num| num.odd? }
p select(array) { |num| puts num }
p select(array) { |num| num + 1 }