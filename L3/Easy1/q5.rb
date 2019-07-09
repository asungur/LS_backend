=begin
Programmatically determine if 42 lies between 10 and 100.

hint: Use Ruby's range object in your solution.
=end

puts (10..100).include?(42)

# LS solution

puts (10..100).cover?(42)