class BeerSong

  class NoBeerSong
    def self.verse(n)
      "No more bottles of beer on the wall, no more bottles of beer.\n" \
      "Go to the store and buy some more, 99 bottles of beer on the wall.\n"
    end
  end

  class SingleBeerSong
    def self.verse(n)
      "1 bottle of beer on the wall, 1 bottle of beer.\n" \
      "Take it down and pass it around, no more bottles of beer on the wall.\n"
    end
  end

  class NBeerSong
    def self.verse(n)
      "#{n} bottles of beer on the wall, #{n} bottles of beer.\n" \
      "Take one down and pass it around, #{n-1} bottles of beer on the wall.\n"
    end
  end

  class TwoBeerSong
    def self.verse(n)
      "2 bottles of beer on the wall, 2 bottles of beer.\n" \
      "Take one down and pass it around, 1 bottle of beer on the wall.\n"
    end
  end

  verses = { 0 => NoBeerSong, 1 => SingleBeerSong, 2 => TwoBeerSong }
  BOTTLE_OPTIONS = Hash.new(NBeerSong).merge(verses).freeze

  def verse(n)
    BOTTLE_OPTIONS[n].verse(n)
  end

  def verses(num1, num2)
    (num2..num1).reverse_each.map{ |n| verse(n) }.join("\n")
  end

  def lyrics
    verses(99, 0)
  end
end

p BeerSong.new.verse(99)