class SumOfMultiples
  def initialize *multiples
    @multiples = multiples.empty? ? [3, 5] : multiples
  end

  def self.to up_to
    SumOfMultiples.new.to up_to
  end

  def to up_to
    (1...up_to).select { |number| multiple? number }
               .inject(0) { |sum, number| sum + number }
  end

  private

  def multiple? number
    @multiples.any? { |multiple| number % multiple == 0 }
  end
end