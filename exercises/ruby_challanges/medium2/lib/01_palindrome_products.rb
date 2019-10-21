class Palindromes
  attr_accessor :palindromes
  attr_reader :max_factor, :min_factor

  def initialize(input)
    @min_factor = input[:min_factor].nil? ? 1 : input[:min_factor]
    @max_factor = input[:max_factor]
    @palindromes = []
  end

  def generate
    (@min_factor..@max_factor).to_a.each do |num|
      if num.to_s.size == 1 || num.to_s == num.to_s.reverse
        @palindromes << num 
      end
    end
    @palindromes
  end
  
end

p Palindromes.new(max_factor: 99, min_factor: 10).generate
