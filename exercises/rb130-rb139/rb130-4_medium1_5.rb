items = ['apples', 'corn', 'cabbage', 'wheat']

def gather(items)
  puts "Let's start gathering food."
  yield(items)
  puts "We've finished gathering!"
end


# TEST 1
gather(items) do |*x,y|
  puts x.join(', ')
  puts y
end
# Let's start gathering food.
# apples, corn, cabbage
# wheat
# We've finished gathering!

# TEST 2
gather(items) do |x,*y,z|
  puts x
  puts y.join(', ')
  puts z
end
# Let's start gathering food.
# apples
# corn, cabbage
# wheat
# We've finished gathering!

# TEST 3
gather(items) do |x,*y|
  puts x
  puts y.join(', ')
end
# Let's start gathering food.
# apples
# corn, cabbage, wheat
# We've finished gathering!

# TEST 4
gather(items) do |a,x,y,z|
  puts [a, x, y, z].join(', ')
end
# Let's start gathering food.
# apples, corn, cabbage, and wheat
# We've finished gathering!