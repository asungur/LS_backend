class Cipher
  attr_accessor :key
  attr_reader   :key_chars

  ALPHABET = ('a'..'z').to_a.freeze
  
  def initialize(key=nil)
    valid?(key) unless key.nil?

    if !key
      random_key = generate_random_key

      @key = random_key
    else
      @key = key
    end
    @key_chars = @key.split('')
  end

  def encode(string)
    encoded_string = ''

    key_chars.each_with_index do |key_char, i|
      break if i >= string.length

      key_index = Cipher::ALPHABET.index(key_char)
      string_char_index = Cipher::ALPHABET.index(string[i])

      new_index = (key_index + string_char_index) % Cipher::ALPHABET.length

      encoded_string << Cipher::ALPHABET[new_index]

    end

    encoded_string
  end

  def decode(string)
    decoded_string = ''

    key_chars.each_with_index do |key_char, i|
      break if i >= string.length

      key_index = Cipher::ALPHABET.index(key_char)
      string_char_index = Cipher::ALPHABET.index(string[i])

      new_index = (string_char_index - key_index) % Cipher::ALPHABET.length

      decoded_string << Cipher::ALPHABET[new_index]

    end

    decoded_string
  end

  private

  def valid?(key)
    raise ArgumentError.new("empty key submitted") if key.length == 0

    filtered_key = key.gsub(/[^a-z]/, '')

    raise ArgumentError.new("invalid key submitted") unless filtered_key == key
  end

  def generate_random_key
    random_key = ''
    max_index = Cipher::ALPHABET.length - 1

    100.times do |_|
      random_index = rand(0..max_index)
      random_key << Cipher::ALPHABET[random_index]
    end

    random_key
  end
end
