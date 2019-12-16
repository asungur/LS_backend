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

  def initialize(string)
    @input = string
  end
  
  def convert
    unless garble?
      chars = identify_chars
      chars.map { |char| ocr_num(char) }.join
    else
      "?"
    end
  end

  def garble?
    

  def ocr_num(char)
    NUMBERS[char.split("\n").map { |line| line.center(3) }.join("\n")]
  end
end