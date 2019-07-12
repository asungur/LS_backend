=begin
Starting with the string:

famous_words = "seven years ago..."

show two different ways to put the expected "Four score and " in front of it.

=end

to_add = "Four score and "

famous_words = "seven years ago..."

puts to_add + famous_words

new = [to_add, famous_words]

puts new.join('')

puts famous_words.prepend(to_add)

puts to_add << famous_words