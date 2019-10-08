=begin

how to work with a coding problem:

- dont underestimate; resist the urge to dive into code
- read the description 3 times; produce an outline if necessary
- communicate and clarify
- have a plan (algorithm), and verify with that
- test cases (happy paths, fail paths, edge cases)
- manage your energy
- abstractions

 Consider a character set consisting of letters, a space, and a point. Words consist of one or more, but at most 20 letters. An input text consists of one or more words separated from each other by one or more spaces and terminated by 0 or more followed by a point. Input should be read from, and including, the first letter of the first word, up to and including the terminating point. The output text is to be produced such that successive words are separated by a single space with the last word being terminated by a single point. Odd words are copied in reverse order whie even words are merely echoed. For example the input string:
 
 "whats the matter with kansas." becomes "whats eht matter htiw kansas."
 
 BONUS POINTS: the characters must be read and printed one at a time.
 
=end


# def reverse_odd(sentence)
#   sentence.gsub!(/\..*/, '')
#   counter = 0
#   temp_word = ''
#   sentence.each_char do |char|
#     if char == ' '
#       puts temp_word
#       counter += 1 if temp_word != ''
#       temp_word = ''
#     elsif char != '.' && char != ' '
#       if counter % 2 == 0
#         temp_word.insert(-1, char)
#       else
#         temp_word.insert(0, char)
#       end
#     else
#       puts temp_word + '.'
#       counter = 0
#       temp_word = ''
#       break
#     end
#   end 
# end

# LS SOLUTION

def reverse_odd(string)
  string.gsub!(/\..*/, '')
  new_words = string.split.map.with_index do |word, i|
    word = word[0...20]
    i.odd? ? word.reverse : word
  end
  new_words.join(' ') + '.'
end





p reverse_odd("hello")
p reverse_odd("hello world.")
p reverse_odd("hello world .")
p reverse_odd("hello  world .")
p reverse_odd("hello world  .")
p reverse_odd("hello word world .")
