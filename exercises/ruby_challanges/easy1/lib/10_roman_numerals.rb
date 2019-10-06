class Integer
  ROMAN_NUMERAL_RULES = {
    "M" => 1000,
    "CM" => 900,
    "D" => 500,
    "CD" => 400,
    "C" => 100,
    "XC" => 90,
    "L" => 50,
    "XL" => 40,
    "X" => 10,
    "IX" => 9,
    "V" => 5
    "IV" => 4,
    "I" => 1
  }
  def to_roman
    str = ''
    number = self
    ROMAN_NUMERAL_RULES.each do |key,value|
      roman_number = number / value
      number = number % value
    