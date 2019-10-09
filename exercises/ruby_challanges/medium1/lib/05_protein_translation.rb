class InvalidCodonError < ArgumentError
end

class Translation
  CODON_TRANSLATION = { %w(AUG) => 'Methionine',
  %w(UUU UUC) => 'Phenylalanine',
  %w(UUA UUG) => 'Leucine',
  %w(UCU UCC UCA UCG) => 'Serine',
  %w(UAU UAC) => 'Tyrosine',
  %w(UGU UGC) => 'Cysteine',
  %w(UGG) => 'Tryptophan',
  %w(UAA UAG UGA) => 'STOP'
  }

  def self.of_codon(string)
    CODON_TRANSLATION.select do |key, val|
      key.include? string
    end.values[0]
  end

  def self.of_rna(string)
    proteins = []
    existing_codons = CODON_TRANSLATION.keys.flatten
    strand_size = string.size / 3
    strand_size.times do |i|
      codon = string[i*3..(i*3)+2]
      raise InvalidCodonError unless existing_codons.include? codon
      break if CODON_TRANSLATION.key('STOP').include? codon
      proteins << of_codon(codon)
    end
    proteins
  end
end
