class SecretHandshake
  ACTIONS = ['wink', 'double blink', 'close your eyes', 'jump'].freeze

  def initialize(num)
    @value = num.to_s.gsub(/[^0-9]/, '').to_i.digits(2)
  end

  def commands
    return_arr = @value.map.with_index { |num, i| ACTIONS[i] if num == 1}.compact
    return_arr.reverse! if @value[4] == 1
    return_arr
  end
end