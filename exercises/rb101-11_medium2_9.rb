def bubble_sort!(array)
  loop do
    swapped = false
    1.upto(array.size - 1) do |index|
      next if array[index - 1] <= array[index]
      array[index - 1], array[index] = array[index], array[index - 1]
      swapped = true
    end
    break if swapped == false
  end
end

arr2 = [6, 2, 7, 1, 4]

bubble_sort!(arr2)

p arr2