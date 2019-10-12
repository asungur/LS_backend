class Atbash
  ALPHABET = ('a'..'z').to_a.freeze

  def self.encode(string)
    @inscription = cleanup(string)
    @translation = encode_str(@inscription)
  end

  def self.cleanup(string)
    string.gsub(/[^a-z0-9]/i, '')
  end

  def self.encode_str(string)
    str_return = ''
    string.each_char do |char|
      str_return << if char =~ /[a-z]/i
                      encode_char(char.downcase)
                    else
                      char
                    end
    end
    split_5(str_return)
  end

  def self.encode_char(letter)
    letter_index = ALPHABET.index(letter)
    new_index = -(letter_index + 1)
    ALPHABET[new_index]
  end

  def self.split_5(string)
    sliced_arr = string.chars.each_slice(5).to_a
    sliced_arr.map(&:join).join(' ')
  end
end
