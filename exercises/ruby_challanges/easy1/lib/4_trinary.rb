class Trinary
  def initialize(num_tri)
    @num = num_tri.split('').map(&:to_i)
    @valid_input = num_tri.gsub(/[^0-2]/, '') == num_tri ? true : false
  end

  def to_decimal
    decimal = 0
    return decimal unless @valid_input
    divider = @num.size - 1
    @num.each do |num|
      decimal += num*3**divider
      divider -= 1
    end
    decimal
  end
end
