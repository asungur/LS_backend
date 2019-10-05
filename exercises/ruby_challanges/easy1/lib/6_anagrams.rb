class Anagram
  def initialize(word)
    @search_word = word.downcase
  end

  def match(arr_words)
    arr_words.select do |word|
      sorted(word) == sorted(@search_word) && word.downcase != @search_word
    end
  end

  def sorted(word)
    word.downcase.split('').sort.join
  end
end