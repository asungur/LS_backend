class Palindromes
  attr_accessor :palindromes

  def initialize(:max_factor, min_factor: 1)
    @min_factor = :min_factor
    @max_factor = :max_factor
  end

  def generate
    @palindromes = (min_factor..max_factor)
      .to_a
      .repeated_combination(2)
      .each_with_object({}) do |(num1, num2), result|
      if palindrome? num1 * num2
        result[num1 * num2] ||= []
        result[num1 * num2] << [num1, num2]
      end
    end.sort
  end



end