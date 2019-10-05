class Octal
  def initialize(str)
    @chars = str.split('').map(&:to_i)
    @valid_input = str.gsub(/[^0-7]/, '') == str ? true : false
  end

  def to_decimal
    decimal = 0
    return decimal unless @valid_input
    divider = @chars.size - 1
    @chars.each do |num|
      decimal += num*(8**divider)
      divider -= 1
    end
    decimal
  end
end

