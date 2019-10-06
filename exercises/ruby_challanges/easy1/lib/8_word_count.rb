class Phrase
  def initialize(text)
    @text = remove_punctuation(text)
    @words = mega_split
  end

  def word_count
    @count = Hash.new(0)
    @words.each do |word|
      @count[word.downcase] += 1
    end
    @count
  end

  def remove_punctuation(text)
    text.gsub(/[:&@.!$%^]/, '')
  end

  def mega_split
    @text.split(",\n")
         .flatten
         .map { |word| word.split(',') }
         .flatten
         .map(&:split)
         .flatten
         .map do |word|
           word[0] == "'" ? word[1...-1] : word
         end
  end
end