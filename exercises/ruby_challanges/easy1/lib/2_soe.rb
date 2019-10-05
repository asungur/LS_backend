class Sieve
  def initialize(num)
    raise StandardError, "Number is too low" if num <= 1
    @max = num
    @arr_search = (2..num).to_a
  end

  def primes
    arr_return = []
    (2..@max).each_with_index do |num,i|
      next if !@arr_search.include?(num)
      arr_return << num
      @arr_search.select! { |mult| mult % num != 0 }
    end
    arr_return
  end
end
