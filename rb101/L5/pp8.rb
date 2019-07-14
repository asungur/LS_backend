# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

vowels = 'aeiou'

hsh.each do |k, v|
  v.each do |str|
    str.chars.each do |c|
      puts c if vowels.include?(c)
    end
  end
end