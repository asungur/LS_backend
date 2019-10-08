class Scrabble
  LETTER_VALUES = { %w(a e i o u l n r s t) => 1,
  %w(d g) => 2,
  %w(b c m p) => 3,
  %w(f h v w y) => 4,
  %w(k) => 5,
  %w(j x) => 8,
  %w(q z) => 10 }.freeze
  
  def initialize(string)
    @word = string.gsub(/[^a-z]/i, '').downcase unless string.nil?
  end

  def score
    word_score = 0
    return word_score if @word.nil? || @word == ''
    @word.each_char do |char|
      LETTER_VALUES.each_pair { |k,v| k.include?(char) ? word_score += v : 0 }
    end
    word_score
  end

  def self.score(word)
    new(word).score
  end
end