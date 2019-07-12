=begin
The Ruby Array class has several methods for removing items from the array.
Two of them have very similar names. Let's see how they differ:
=end

numbers = [1, 2, 3, 4, 5]

# What do the following method calls do (assume we reset numbers to the original array between method calls)?

numbers.delete_at(1)
puts numbers # deletes 2 cause its at index 1 (mutates the caller)
numbers.delete(1)
puts numbers # searches integer 1 and deletes the item (mutates the caller)