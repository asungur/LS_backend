=begin
Sort an array of passed in values using merge sort. 
You can assume that this array may contain only one type 
of data. And that data may be either all numbers or 
all strings.

Merge sort is a recursive sorting algorithm that works by 
breaking down the array elements into nested sub-arrays,
then recombining those nested sub-arrays in sorted order.
It is best shown by example. For instance, let's 
merge sort the array [9,5,7,1]. Breaking this down 
into nested sub-arrays, we get:

[9, 5, 7, 1] ->
[[9, 5], [7, 1]] ->
[[[9], [5]], [[7], [1]]]
We then work our way back to a flat array
by merging each pair of nested sub-arrays:

[[[9], [5]], [[7], [1]]] ->
[[5, 9], [1, 7]] ->
[1, 5, 7, 9]
=end


# ALTERNATIVE LS solution

def merge(arr1, arr2)
  index2 = 0
  result = []
  arr1.each do |value|
    while index2 < arr2.size && arr2[index2] <= value
      result << arr2[index2]
      index2 += 1
    end
    result << value
  end
  result.concat(arr2[index2..-1])
end



puts merge([1, 5, 9], [2, 6, 8]) == [1, 2, 5, 6, 8, 9]
puts merge([1, 1, 3], [2, 2]) == [1, 1, 2, 2, 3]
puts merge([], [1, 4, 5]) == [1, 4, 5]
puts merge([1, 4, 5], []) == [1, 4, 5]






