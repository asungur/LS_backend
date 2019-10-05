class DNA
  def initialize(strand)
    @strand = strand
  end

  def hamming_distance(check_strand)
    strand_1 = @strand[0, check_strand.length]

    strand_1.chars.zip(check_strand.chars).count { |pair| pair.first != pair.last }
  end
end