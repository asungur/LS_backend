class Palindromes
  attr_reader :max_factor, :min_factor

  def initialize(input)
    @min_factor = input[:min_factor].nil? ? 1 : input[:min_factor]
    @max_factor = input[:max_factor]
    @palindromes = Hash.new { |hash, key| hash[key] = [] }
  end

  def generate
    (@min_factor..@max_factor).to_a.repeated_combination(2) do |num1, num2|
      @palindromes[num1 * num2] << [num1,num2] if mirrored?(num1 * num2)
    end
    @palindromes
  end

  def mirrored?(num)
    num.to_s == num.to_s.reverse
  end

  def largest
    max_palindrome = @palindromes.max_by { |k, v| k }
    Struct.new(:value, :factors).new(max_palindrome[0], max_palindrome[1])
  end

  def smallest
    min_palindrome = @palindromes.min_by { |k, v| k }
    Struct.new(:value, :factors).new(min_palindrome[0], min_palindrome[1])
  end
end

