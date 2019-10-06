class PerfectNumber
  def self.classify(number)
    raise RuntimeError if number < 0

    factors = (1...number).select { |num| number % num == 0 }

    result = factors.reduce(:+)

    case
      when result < number then 'deficient'
      when result > number then 'abundant'
      when result == number then 'perfect'
    end
  end
end