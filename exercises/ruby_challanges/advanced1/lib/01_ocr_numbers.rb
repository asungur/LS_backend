class OCR
    NUMBERS = { " _ \n| |\n|_|" => '0',
              "   \n  |\n  |" => '1',
              " _ \n _|\n|_ " => '2',
              " _ \n _|\n _|" => '3',
              "   \n|_|\n  |" => '4',
              " _ \n|_ \n _|" => '5',
              " _ \n|_ \n|_|" => '6',
              " _ \n  |\n  |" => '7',
              " _ \n|_|\n|_|" => '8',
              " _ \n|_|\n _|" => '9' }

  def initialize(text)
    @text = text
  end

  def convert
    @text.split("\n\n").map do |text|
      nums_as_binary_font(text).map do |num_as_binary_font|
        NUMBERS[num_as_binary_font] || '?'
      end.join
    end.join(',')
  end

  private

  def nums_as_binary_font(lines)
    rows(lines).transpose.map do |num_as_binary_font_arr|
      num_as_binary_font_arr.map { |line| line.join.center(3) }.join("\n")
    end
  end

  def rows(lines)
    lines.split("\n").map do |row|
      row.center(3).chars.each_slice(3).to_a
    end
  end
end