# Write a method that changes the first occurrence of the word apple, blueberry, or cherry in a string to danish.

def danish(string)
  string.sub(/\b(apple|blueberry|cherry)\b/, "danish")
end

p danish('An apple a day keeps the doctor away')
# -> 'An danish a day keeps the doctor away'

p danish('My favorite is blueberry pie')
# -> 'My favorite is danish pie'

p danish('The cherry of my eye')
# -> 'The danish of my eye'

p danish('apple. cherry. blueberry.')
# -> 'danish. cherry. blueberry.'

p danish('I love pineapple')
# -> 'I love pineapple'