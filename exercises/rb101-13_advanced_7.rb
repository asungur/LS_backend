=begin
Write a method that takes two sorted Arrays as arguments,
and returns a new Array that contains all elements from 
both arguments in sorted order.

You may not provide any solution that requires you to sort 
the result array. You must build the result array one element 
at a time in the proper order.

!!! Your solution should not mutate the input arrays. !!!

Examples:
=end


def merge(arr1_temp, arr2_temp)
  # Reassignment to prevent mutation
  arr1 = arr1_temp
  arr2 = arr2_temp
  new_arr = []
  # Check if either of the lists is empty, combine if true
  loop do
    if arr1 == [] || arr2 == []
      new_arr += arr1 + arr2
      new_arr.flatten!
    end
    break if arr1 == [] || arr2 == []
    # comparison iteration
    case arr1[0] <=> arr2[0]
    when -1
      new_arr << arr1.shift
    when 0
      new_arr << arr1.shift
      new_arr << arr2.shift
    when 1
      new_arr << arr2.shift
    end
  end
  new_arr
end






puts merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
puts merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
puts merge([], [1, 4, 5]) == [1, 4, 5]
puts merge([1, 4, 5], []) == [1, 4, 5]