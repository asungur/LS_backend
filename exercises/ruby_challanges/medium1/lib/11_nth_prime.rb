class Prime
  def self.nth(number)
    if number < 1
      raise ArgumentError
    elsif number == 1
      return 2
    else
      counter = 1
      check_num = 1
      while counter < number
        check_num += 2
        counter += 1 if prime_num?(check_num)
      end
      check_num
    end
  end

  def self.prime_num?(num)
    return true if num == 2 || num == 3
    (2..(Math.sqrt(num)).floor).to_a.all? { |n| num % n != 0 }
  end
end


