text = File.read('project_gutenbergs_frankenstein.txt')

book = text.split(
  "*** START OF THIS PROJECT GUTENBERG EBOOK FRANKENSTEIN ***"
  )[1]

max_len = 0

book.split(/\.|\?|\!/).each do |sent|
  max_len = sent.split(' ').size if sent.split(' ').size > max_len
end

puts max_len
