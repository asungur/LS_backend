words = "the flintstones rock"
=begin
would be:

words = "The Flintstones Rock"
Write your own version of the rails titleize implementation.
=end

def titleize(sentence)
  sentence.split(' ').map { |word| word.capitalize }.join(' ')
end

puts titleize(words)