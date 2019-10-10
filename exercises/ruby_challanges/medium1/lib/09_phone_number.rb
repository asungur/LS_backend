class PhoneNumber
  def initialize(number)
    @number = number.to_s.gsub(/[^0-9]/, '')
    @bad_number = bad_number?(number)
  end

  def bad_number?(number)
    return true if number =~ /[a-z]/i
    length = @number.size
    if length == 10 || length == 11 && @number[0] == '1'
      return false
    else
      return true
    end
  end

  def to_s
    '(' + @number[-10..-8] + ') ' + @number[-7..-5] + '-' + @number[-4..-1]
  end

  def area_code
    @number[0..2] unless @bad_number
  end

  def number
    return '0000000000' if @bad_number
    @number[-10..-1]
  end
end
