=begin
Write a method that calculates and returns the index of the first Fibonacci 
number that has the number of digits specified as an argument. 
(The first Fibonacci number has index 1.)

find_fibonacci_index_by_length(2) == 7          # 1 1 2 3 5 8 13

=end

def find_fibonacci_index_by_length(num = 2)
  base = [1,1]
  while num > base[-1].digits.size do 
    base << (base[-1] + base[-2])
  end
  base.index(base[-1])
end

p find_fibonacci_index_by_length(4)

