class Luhn
  def initialize(num)
    @value = num
  end

  def addends
    num_digits = @value.digits
    num_digits.map.with_index do |char, i|
      if i.even?
        char
      else
        char * 2 >= 10 ? char * 2 - 9 : char * 2
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    (checksum % 10).zero?
  end

  def self.create(num)
    remainder = new(num * 10).checksum % 10
    num * 10 + (remainder.zero? ? 0 : 10 - remainder)
  end
end