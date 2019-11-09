class Diamond
  LETTERS = ('A'..'Z').to_a
  def self.make_diamond(letter)
    diamond_quarter_size = LETTERS.index(letter) + 1
    empty_quarter = ' ' * diamond_quarter_size
    diamond_quarter = ''
    diamond_bottom_half = []
    diamond_quarter_size.times do |index|
      right_row = empty_quarter.dup
      right_row[index] = LETTERS[index]
      right_row += "\n"
      left_row = right_row[1..-2].reverse
      diamond_quarter << (left_row + right_row)
      diamond_bottom_half << (left_row + right_row)
    end
    diamond_bottom_half.pop
    diamond_quarter << diamond_bottom_half.reverse.join('')
    diamond_quarter
  end
end
