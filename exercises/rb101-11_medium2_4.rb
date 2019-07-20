# MATCHING PARANTHESIS
=begin
Write a method that takes a string as argument,
and returns true if all parentheses in the string are properly balanced, 
false otherwise. To be properly balanced, parentheses must occur in matching 
'(' and ')' pairs.

Things to check:
1. If the correct opener used
2. If the correct closer used
3. If paranthesis used in the correct order
=end

DOUBLES = [
  ['(',')'],
  ['[', ']'],
  ['{', '}']
  ]
QUOTES = ['\"','\'']



def check_duo?(str, pair)
  val = 0
  str.each_char do |char|
    val += 1 if char == pair[0]
    val -= 1 if char == pair[1]
    break if val < 0 
  end
  val == 0
end

def pairs_check?(string)
  result = []
  DOUBLES.each do |pair|
    result << check_duo?(string,pair)
  end
  QUOTES.each do |quote|
    result << string.chars.count { |char| char == quote}.even?
  end
  result.all? {|element| element == true}
end
