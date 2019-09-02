# Update this class so you can use it to determine the lowest ranking and highest ranking cards in an Array of Card objects:

class Card
  attr_reader :rank, :suit

  VALUES = {'Jack' => 11, 'Queen' => 12, 'King' => 13, 'Ace' => 14}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def <=>(other)
    
end