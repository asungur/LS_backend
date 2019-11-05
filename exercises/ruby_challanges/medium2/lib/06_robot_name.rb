class Robot
  @@robot_names = []
  attr_reader :name
  def initialize
    generate_name
  end

  def generate_name
    random_name = nil
    alphabetical = ('A'..'Z').to_a
    loop do
      first_char = alphabetical[rand(alphabetical.size - 1)]
      second_char = alphabetical[rand(alphabetical.size - 1)]
      third_char = rand(10)
      fourth_char = rand(10)
      fifth_char = rand(10)
      chars_arr = [first_char, second_char, third_char, fourth_char, fifth_char]
      random_name = chars_arr.map(&:to_s).join('')
      break unless @@robot_names.include?(random_name)
    end
    @@robot_names << random_name
    @name = random_name
  end

  def reset
    @@robot_names.delete(@name)
    generate_name
  end
end
