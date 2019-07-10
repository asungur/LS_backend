# What is the result of the last line in the code below?

greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# hi there, because:
# 1 - informal_greeting is being referenced to greetings[:a]
# 2 - << modifies the original which has been referenced, so referenced
# object is mutated