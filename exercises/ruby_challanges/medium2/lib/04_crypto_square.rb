class Crypto
  def initialize(text)
    @normalized_plaintext = text.gsub(/[^a-zA-Z0-9]/, '').downcase
  end

  def normalize_plaintext
    @normalized_plaintext
  end

  def size
    Math.sqrt(@normalized_plaintext.size).ceil
  end

  def plaintext_segments
    @normalized_plaintext.scan(/.{1,#{size}}/)
  end

  def ciphertext
    encode_plaintext
  end

  def normalize_ciphertext
    encode_plaintext(' ')
  end

  def encode_plaintext(delimiter='')
    padded_segments = plaintext_segments.map { |string| right_pad(string, size) }
    padded_segments.map(&:chars).transpose.map(&:join).map(&:strip).join(delimiter)
  end

  def right_pad(string, size_limit)
    string + ' ' * (size_limit - string.size)
  end
end